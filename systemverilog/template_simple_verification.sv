/* Strings
    - dynamic array of elements of type byte with methods defined to manipulate strings
    - resizes automatically when character appended or removed
    - special C like escaped chars such as \n, \r, \t, \\, \, octal character representations etc are
      also valid characters for a SV string. Additonal escape chars allowed are
        - \f form feed
        - \v vertical tab
        - \a bell
        - \xdd hexadecimal encoding of an ASCII character
    - length N string has indexes from 0 to N-1
    - indexing empty string generates out of bound access error
    - operations alllowed are read, write, comparison, concatenation, replication, indexing
    - Operators
      - comparison: == (equality), != (not equal), <, <=, >, >=
      - concatenation: {str1, str2, str3} 
      - replication: {N{str}} returns string with N replicas of string str
      - indexing: str[index] where index = 0 to N-1 where N = number of character in string
    - Methods
      len()                 returns string length
      putc(int i, byte c)   replaces i-th index location with byte value  c
      getc(int i)           returns ASCII byte code of character at index i
      compare(string s)     case-sensitive comparison of string with string s as per lexical order
      icompare(string s)    case-insensitive comparison of string with string s as per lexical order
      substr(int i, int j)  returns substring of string between indexes i and j
      toupper()             returns string in upper case
      tolower()             returns string in lower case
      atobin()              returns integer value for ASCII characters of a string representing binary numbers
      atooct()              returns integer value for ASCII characters of a string representing octal numbers
      atohex()              returns integer value for ASCII characters of a string representing hexadecimal numbers
      atoi()                returns integer value for ASCII characters of a string representing integer numbers
      atoreal()             returns real value for ASCII characters of a string representing a real number
      bintoa(int i)         stores inside a string ASCII character representation of a number in binary format
      octtoa(int i)         stores inside a string ASCII character representation of a number in octal format
      hextoa(int i)         stores inside a string ASCII character representation of a number in hex format
      itoa(int i)           stores inside a string ASCII character representation of a number in integer format 
      realtoa(real r)       stores inside a string ASCII character representation of a number in real format 
*/
  string str1 = "test steing";
  string emptrystr; // default value is empty string ""

  str1 = "new string";  // string assigned value. String value now: "new string"
  str1[3] = "k";        // string indexed at location 2 assinged value "k". String value now: "newkstring"

  string strcpies;
  strcpies = {3{"hello "}}; String value now: "hello hello hello"