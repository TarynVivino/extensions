Version 1.3.1 of Tabulate by Zed Lopez begins here.

"Provides a phrase to go from a text to a table name, and a not-for-release
tabulate action to show the contents of a table."

Use authorial modesty.

Section Null (For use without Central Typecasting by Zed Lopez)

To decide which K is the/a/-- null (name of kind of value K): (- nothing -)

Part Text to Table Name

To decide what table name is (T - a text) as a table name:
    let t be T in lower case;
    repeat with tbl running through table names begin;
      let tbl-text be "[tbl]";
      let tbl-name be "[tbl-text in lower case]";
      if "[t]" is tbl-name or "table of [t]" is tbl-name, decide on tbl;
    end repeat;
    decide on the null table name.

Part Tabulate Action (not for release)

Tabulating is an action out of world applying to one topic.

The tabulating action has a table name called the table understood.

Understand "tabulate [text]" as tabulating.

Check tabulating:
    let t be the substituted form of "[the topic understood]";
    now the table understood is t as a table name;
    if the table understood is the null table name, instead say "I can't find a table named [t]."

Carry out tabulating:
  showme the contents of the table understood.

Tabulate ends here.
