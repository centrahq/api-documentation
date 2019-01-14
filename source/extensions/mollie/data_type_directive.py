from docutils import nodes
from docutils.parsers.rst import Directive
from source.extensions import utilities


class DataTypeDirective(Directive):
    has_content = False
    required_arguments = 1
    final_argument_whitespace = True
    option_spec = {
        "required": utilities.validate_bool,
        "storetype": utilities.validate_string
    }

    primitive_types = ["integer", "boolean", "float", "string"]

    def run(self):
        data_type = self.arguments[0]

        condition = None

        if "required" in self.options:
            if self.options["required"] is True:
                condition = "required"
            elif self.options["required"] is False:
                condition = "optional"

        storetype = None
        if "storetype" in self.options:
            storetype = self.options["storetype"]

        container = nodes.container()

        if condition is not None:
            container["classes"].extend([self.name, condition])

        if storetype is not None:
            container["classes"].extend([self.name, storetype])

        data_type_line = nodes.line(text=data_type)

        if self.is_primitive_type(data_type):
            data_type_line["classes"].extend([self.name, "datatype", "primitive"])
        else:
            data_type_line["classes"].extend([self.name, "datatype"])

        if condition is not None:
            condition_line = nodes.line(text=condition)
            condition_line["classes"].extend([self.name, "condition"])

            container += [data_type_line, condition_line]
        else:
            container += [data_type_line]

        if storetype is not None:
            storetype_line = nodes.line(text=storetype)
            storetype_line["classes"].extend([self.name, "condition", "storetype"])

            container += [storetype_line]


        return [container]

    def is_primitive_type(self, type_string):
        return type_string in self.primitive_types
