### Uploading product media using AWS S3 pre-signed POST:

AWS Pre-signed POST data enables direct uploads to S3 storage in controlled and safe way.

The client makes request for obtaining pre-signed POST Policy containing URL and data fields required to prepare multipart/form-data POST request to upload file directly to S3.
S3 will respond with successful response or error message if upload fails.

The policy expires after 20 minutes by default and its expiration is adjustable by configuration.

### How does it work in Integration API:

Product media upload flow consists of 3 steps.

Obtain the policy from Integration API endpoint, upload file to S3 using that policy and assign uploaded file to proper object - either Product or ProductVariant.
Files that are uploaded but not assigned tI o any existing Product or ProductVariant will be removed after 2 days.

Required permission is `ProductMedia:write`

### Product media upload flow:

- Use `createMediaUpload` mutation to obtain pre-signed POST policy along with unique identifier of the file.


- Use policy data to construct an upload request with your file to S3 (see code examples)


- After successful upload use `completeMediaUpload` mutation with unique identifier to assign uploaded media to proper Product or ProductVariant. If your file wasn't uploaded successfully and cannot be found by given identifier the mutation will fail.

### Notes

- `Content-Type` field in form data is obligatory due to mime type restrictions and must be set to the value of uploaded file type before the actual file input.


- Supported file formats are png/jpg/gif


- Successful response from S3 file upload request is indicated by 204 status code

### Code examples:

- Upload javascript function using xhr request:

```javascript
const uploadFile = (uploadPolicy, file) => {
    return new Promise((resolve, reject) => {
        
        const formData = new FormData();
        Object.keys(uploadPolicy.fields).forEach(field => {
            formData.append(field.name, field.value);
        });

        const actionAttribute = uploadPolicy.attributes.find(attribute => attribute.name === 'action');
        const url = actionAttribute.value;

        formData.append('Content-Type', file.type);
        formData.append("file", file);
        const xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.send(formData);

        xhr.onload = function() {
            this.status === 204 ? resolve() : reject(this.responseText);
        };
    });
};

```

- HTML template with dynamically created media upload form:

```html

<!DOCTYPE html>
<html>

<head>
    <title>
        Test AWS s3 pre-signed post form media upload
    </title>
</head>

<body>
<div>
    <form id='gql-form'>
        <label for='gql-input'>Paste GraphQL response:</label>
        <textarea id='gql-input'></textarea>
        <button type="submit">Generate Form</button>
    </form>
    <div><b>UUID:</b><span id='uuid-container'/></div>
</div>
<div id="test-form-container">
</div>

<script>
    function generateForm(e) {
        e.preventDefault();
        let input = document.getElementById('gql-input');
        let parsed = JSON.parse(input.value);
        if (parsed === false) {
            console.error('Invalid response -- not a valid JSON');
        }
        createForm(parsed);
        return false;
    }

    window.onload = function exampleFunction() {
        document.getElementById('gql-form').addEventListener('submit', generateForm);
    }

    function createForm(gqlResponse) {
        let formContainer = document.getElementById('test-form-container');
        formContainer.innerHTML = '';
        document.getElementById('uuid-container').innerText = gqlResponse.data.createMediaUpload.UUID;
        let policy = gqlResponse.data.createMediaUpload.uploadPolicy;
        let formAttributes = policy.attributes;
        let formInputs = policy.fields;

        var form = document.createElement("form");
        formAttributes.forEach(function (attr) {
            form.setAttribute(attr.name, attr.value)
        });

        formInputs.forEach(function(input) {
            let inputElem = document.createElement("input");
            inputElem.setAttribute('type', 'hidden');
            inputElem.setAttribute('name', input.name);
            inputElem.setAttribute('value', input.value);
            form.appendChild(inputElem);
        });

        let fileInput = document.createElement("input");
        fileInput.setAttribute('type', 'file');
        fileInput.setAttribute('name', 'file');
        form.appendChild(fileInput);

        let submit = document.createElement("input");
        submit.setAttribute('type', 'submit');
        submit.setAttribute('value', 'upload');
        form.appendChild(submit)

        fileInput.addEventListener('input', function(e) {
            let inputElem = document.createElement("input");
            inputElem.setAttribute('type', 'hidden');
            inputElem.setAttribute('name', "Content-Type");
            inputElem.setAttribute('value', fileInput.files[0].type);
            form.insertBefore(inputElem, fileInput);
        });

        formContainer.appendChild(form);
    }
</script>
</body>
</html>


```
