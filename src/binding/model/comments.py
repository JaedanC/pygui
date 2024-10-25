from typing import List, Optional
import textwrap


class Comments:
    def __init__(self, comment_preceeding: List[str], comment_attached: str):
        self.comment_proceeding: List[str] = comment_preceeding
        self.comment_attached: str         = comment_attached

        if self.comment_attached is not None:
            self.comment_attached = self.comment_attached.replace('"', "'")
            self.comment_attached = self.comment_attached.replace('{', "(")
            self.comment_attached = self.comment_attached.replace('}', ")")
            self.comment_attached = self.comment_attached.lstrip("// ").capitalize()
        
        self.comment_proceeding = [line.lstrip("// ") for line in self.comment_proceeding]
        self.comment_proceeding = [line.replace("{", "(") for line in self.comment_proceeding]
        self.comment_proceeding = [line.replace("}", ")") for line in self.comment_proceeding]

    def three_quote_all_comments(self) -> Optional[str]:
        if len(self.comment_proceeding) == 0 and self.comment_attached is None:
            return None
        
        comment_attached_no_none = self.comment_attached if self.comment_attached is not None else ""
        
        comment = textwrap.dedent(
        '''
        """
        {}
        """
        ''')

        if len(self.comment_proceeding) == 0 or self.comment_attached is None:
            comment = comment.format(
                "\n".join(self.comment_proceeding) + comment_attached_no_none.capitalize())
        else:
            comment = comment.format(
                "\n".join(self.comment_proceeding) + "\n" + comment_attached_no_none.capitalize())
        return comment.strip()

    def three_quote_proceeding_only(self) -> Optional[str]:
        if len(self.comment_proceeding) == 0:
            return None
        
        return textwrap.dedent(
        '''
        """
        {}
        """
        '''.format("\n".join(self.comment_proceeding)))
        return comment

    def hash_all_comments(self) -> Optional[str]:
        if len(self.comment_proceeding) == 0 and self.comment_attached is None:
            return None
        
        if len(self.comment_proceeding) > 0 and self.comment_attached is not None:
            return textwrap.dedent(
                """
                {}
                # {}
                """).format(
                    "\n".join(["# " + line for line in self.comment_proceeding]),
                    self.comment_attached
                ).strip("\n")
        
        if len(self.comment_proceeding) > 0:
            return "\n".join(["# " + line for line in self.comment_proceeding])
        return "# " + self.comment_attached

    def hash_proceeding_only(self) -> Optional[str]:
        if len(self.comment_proceeding) == 0:
            return None

        return "\n".join(["# " + line for line in self.comment_proceeding])

    def hash_attached_only(self) -> Optional[str]:
        if self.comment_attached is None:
            return None
        return "# " + self.comment_attached


def parse_comment(json_containing_comment) -> Comments:
    proceeding = []
    attached = None
    if "comments" not in json_containing_comment:
        return Comments(proceeding, attached)
    
    if "attached" in json_containing_comment["comments"]:
        attached = json_containing_comment["comments"]["attached"]
    
    if "preceding" in json_containing_comment["comments"]:
        proceeding = json_containing_comment["comments"]["preceding"]
    return Comments(proceeding, attached)
