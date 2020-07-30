{ok,Pid} = mysql:start_link([
{host,"localhost"},
{user, "he"},
{password,"1"},
{database,"test"}]).

ok = mysql:query(Pid, 
"INSERT INTO user_table (username,password,age) VALUES (?, ?)", 
["何远松",123,23]).

{ok, ColumnNames, Rows}=mysql:query(Pid, 
"SELECT * FROM user_table WHERE id = ?", [1]).
