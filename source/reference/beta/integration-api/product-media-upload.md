### Uploading product media using AWS S3 pre-signed POST:

AWS Pre-signed POST data enables direct uploads to S3 storage in a controlled and safe way.

The client makes request for obtaining pre-signed POST Policy containing URL and data fields 
required to prepare multipart/form-data POST request to upload a file directly to S3.
S3 will respond with successful response or error message if upload fails.

The policy expires after 20 minutes by default and its expiration is adjustable by configuration.

### How does it work with GraphQL Integration API:

Product media upload flow consists of 3 steps.

1. Obtain the policy from Integration API mutation, 
2. Upload file to S3 using that policy, 
3. Assign uploaded file to a proper object - either Product or ProductVariant.

Files that are uploaded but not assigned to any existing Product or ProductVariant will be removed 
after 2 days.

Required permission is `ProductMedia:write`

### Product media upload flow:

- Use `createMediaUpload` mutation to obtain pre-signed POST policy along with unique identifier 
  of the file.
- Use policy data to construct an upload request with your file to S3 (see code examples).
- After successful upload use `completeMediaUpload` mutation with the unique identifier to assign 
  uploaded media to proper Product or ProductVariant. If your file wasn't uploaded successfully 
  and cannot be found by given identifier, the mutation will fail.

### Notes

- `Content-Type` field in form data is obligatory due to mime type restrictions and must be set 
  to the value of uploaded file type before the actual file input.
- Supported file formats are png, jpg and gif.
- Successful response from S3 file upload request is indicated by 204 status code.

### Code examples:

- JavaScript upload function using XHR request:

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
    <title>Test media upload with pre-signed POST policy</title>
    <style>
      .add-margin { margin: 1em; }
      .success { color: green; }
      textarea:valid { border: 2px solid green; }
      textarea:invalid { border: 2px solid red; }
    </style>
  </head>
  
  <body>
    <div class="add-margin">
      <h2>Test media upload with pre-signed POST policy</h2>
      <form id="gql-form">
        <div><label for="gql-input">Paste raw GraphQL response from <code>createMediaUpload</code> mutation:</label></div>
        <div><textarea id="gql-input" cols="80" rows="20" required autofocus></textarea></div>
        <div><button type="submit">Generate Form</button></div>
      </form>
    </div>
    <div class="add-margin"><b>UUID:</b> <span id="uuid-container"/></div>
    <div id="test-form-container" class="add-margin"></div>
    <div id="after-submit" class="add-margin success"></div>
    
    <script>
      function generateForm(e) {
        e.preventDefault();
        const input = document.getElementById('gql-input');
        try {
          const parsed = JSON.parse(input.value);
          createForm(parsed);
        } catch (e) {
          console.error('Invalid response - not a valid JSON.' + e);
        }
        document.getElementById('after-submit').innerHTML = '';
        return false;
      }
    
      window.onload = function exampleFunction() {
        document.getElementById('gql-form').addEventListener('submit', generateForm);
      }
    
      function createForm(gqlResponse) {
        const formContainer = document.getElementById('test-form-container');
        formContainer.innerHTML = '';
        document.getElementById('uuid-container').innerText = gqlResponse.data.createMediaUpload.UUID;
        const policy = gqlResponse.data.createMediaUpload.uploadPolicy;
        const formAttributes = policy.attributes;
        const formInputs = policy.fields;
    
        const form = document.createElement('form');
        formAttributes.forEach(function (attr) {
          form.setAttribute(attr.name, attr.value)
        });
    
        formInputs.forEach(function(input) {
          let inputElem = document.createElement('input');
          inputElem.setAttribute('type', 'hidden');
          inputElem.setAttribute('name', input.name);
          inputElem.setAttribute('value', input.value);
          form.appendChild(inputElem);
        });
    
        const fileInput = document.createElement('input');
        fileInput.setAttribute('type', 'file');
        fileInput.setAttribute('name', 'file');
        fileInput.setAttribute('accept', 'image/*');
        form.appendChild(fileInput);
    
        const submit = document.createElement('input');
        submit.setAttribute('type', 'submit');
        submit.setAttribute('value', 'Upload');
        form.appendChild(submit)
    
        fileInput.addEventListener('input', function(e) {
          let inputElem = document.createElement('input');
          inputElem.setAttribute('type', 'hidden');
          inputElem.setAttribute('name', 'Content-Type');
          inputElem.setAttribute('value', fileInput.files[0].type);
          form.insertBefore(inputElem, fileInput);
        });
    
        form.addEventListener('submit', function(e) {
          const afterSubmitInfo = document.getElementById('after-submit');
          afterSubmitInfo.innerHTML = '<h3>File uploaded! Now go and run the ' +
                  '<code>completeMediaUpload</code> to connect it with a Product or ProductVariant</h3>';
          return false;
        });
        
        formContainer.appendChild(form);
      }
    </script>
  </body>
</html>


```
