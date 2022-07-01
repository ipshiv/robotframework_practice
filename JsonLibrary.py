# -*- coding: utf-8 -*-
import json


class JsonLibrary:
    """Tiny JSON library to deal with JSON

    == Dependencies ==
    robot framework | http://robotframework.org |

    == Example ==
    //TODO Fill this section
    """

    def validate_json(self, json_str):
        """Validate JSON.\n
        *Args:*\n
            _json_str_: JSON string.\n
        *Returns:*\n
            True if JSON is valid.\n
        *Example:*\n
        |${is_json}= | Validate Json | json_str=json |
        """
        try:
            json.loads(json_str)
        except json.JSONDecodeError:
            return False
        else:
            return True

    def convert_json_to_dictionary(self, json_str):
        """Convert JSON string into dictionary\n
        *Args:*\n
            _json_str_: JSON string.\n
        *Returns:*\n
            Dictionary.\n
        *Example:*\n
        |${dict}= | Convert Json To Dictionary | json_str=json |
        """
        new_dict = {}
        return new_dict

    def convert_dict_to_json(self, dict):
        """Convert dictionary into JSON string\n
        *Args:*\n
            _dict_: Dictionary.\n
        *Returns:*\n
            JSON string.\n
        *Example:*\n
        |${json}= | Convert Json To Dictionary | json_str=json |
        """
        str = ""
        return str
