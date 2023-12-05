*************************************************************************
*
* Source File Name: SQLCODES
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function: Include File defining:
*	      Labels for SQLCODES
*
* Operating System:  Windows NT
*
**************************************************************************
* SQL Return Codes in SQLCODE

* ------------ warnings ------------
* correlation without qualification
 77  SQL-RC-W012	       PIC S9(4) COMP-5 VALUE 12.
* unsupported bind/prep options
 77  SQL-RC-W020	       PIC S9(4) COMP-5 VALUE 20.
* eof
 77  SQL-RC-W100	       PIC S9(4) COMP-5 VALUE 100.
* duplicate column conistraint
 77  SQL-RC-W139	       PIC S9(4) COMP-5 VALUE 139.
* invalid syntax ignored
 77  SQL-RC-W143	       PIC S9(4) COMP-5 VALUE 143.
* explain mode incompatible
 77  SQL-RC-W217	       PIC S9(4) COMP-5 VALUE 217.
* not enough sqlvars, none filled in
 77  SQL-RC-W236	       PIC S9(4) COMP-5 VALUE 236.
* distinct type: not enough sqlvars, some filled in
 77  SQL-RC-W237	       PIC S9(4) COMP-5 VALUE 237.
* LOB type: not enough sqlvars, none filled in
 77  SQL-RC-W238	       PIC S9(4) COMP-5 VALUE 238.
* distinct type: not enough sqlvars, none filled in
 77  SQL-RC-W239	       PIC S9(4) COMP-5 VALUE 239.
* new view replaced old
 77  SQL-RC-W280	       PIC S9(4) COMP-5 VALUE 280.
* possible infinite loop
 77  SQL-RC-W347	       PIC S9(4) COMP-5 VALUE 347.
* alias target is not defined
 77  SQL-RC-W403	       PIC S9(4) COMP-5 VALUE 403.
* clause value has been replaced
 77  SQL-RC-W434	       PIC S9(4) COMP-5 VALUE 434.
* Sub-optimal query
 77  SQL-RC-W437	       PIC S9(4) COMP-5 VALUE 437.
* Function has truncated value
 77  SQL-RC-W445	       PIC S9(4) COMP-5 VALUE 445.
* Create UDF contains redundant keyw
 77  SQL-RC-W447	       PIC S9(4) COMP-5 VALUE 447.
* UDF returns a warning sqlstate
 77  SQL-RC-W462	       PIC S9(4) COMP-5 VALUE 462.
* DDL:could truncate value at runtime
 77  SQL-RC-W474	       PIC S9(4) COMP-5 VALUE 474.
* DDL:could truncate value at runtime
 77  SQL-RC-W477	       PIC S9(4) COMP-5 VALUE 477.
* duplicate referential constraint
 77  SQL-RC-W541	       PIC S9(4) COMP-5 VALUE 541.
* Isolation level escalated
 77  SQL-RC-W595	       PIC S9(4) COMP-5 VALUE 595.
* existing index used
 77  SQL-RC-W598	       PIC S9(4) COMP-5 VALUE 598.
* compare func not created for lstr
 77  SQL-RC-W599	       PIC S9(4) COMP-5 VALUE 599.
* index already exists
 77  SQL-RC-W605	       PIC S9(4) COMP-5 VALUE 605.
* unknown SQL warning another product
 77  SQL-RC-W965	       PIC S9(4) COMP-5 VALUE 965.
* XA informational message
 77  SQL-RC-W997	       PIC S9(4) COMP-5 VALUE 997.
* XA no data to return from recover
 77  SQL-RC-W1251	       PIC S9(4) COMP-5 VALUE 1251.
* Trailing blanks are truncated
 77  SQL-RC-W1580	       PIC S9(4) COMP-5 VALUE 1580.
* Event monitor state not changed
 77  SQLM-RC-NOT-SET	       PIC S9(4) COMP-5 VALUE 1615.

* ------------ errors ------------
* illegal character
 77  SQL-RC-E007	       PIC S9(4) COMP-5 VALUE -7.
* string constant not terminated
 77  SQL-RC-E010	       PIC S9(4) COMP-5 VALUE -10.
* cursor or statement name = ""
 77  SQL-RC-E013	       PIC S9(4) COMP-5 VALUE -13.
* INTO clause required
 77  SQL-RC-E029	       PIC S9(4) COMP-5 VALUE -29.
* reserved
 77  SQL-RC-E051	       PIC S9(4) COMP-5 VALUE -51.
* bad SQL statement
 77  SQL-RC-E084	       PIC S9(4) COMP-5 VALUE -84.

* statement too long
 77  SQL-RC-E101	       PIC S9(4) COMP-5 VALUE -101.
* string constant too long
 77  SQL-RC-E102	       PIC S9(4) COMP-5 VALUE -102.
* invalid numeric literal
 77  SQL-RC-E103	       PIC S9(4) COMP-5 VALUE -103.
* invalid character/token
 77  SQL-RC-E104	       PIC S9(4) COMP-5 VALUE -104.
* invalid string constant
 77  SQL-RC-E105	       PIC S9(4) COMP-5 VALUE -105.
* name too long
 77  SQL-RC-E107	       PIC S9(4) COMP-5 VALUE -107.
* name has too many qualifiers
 77  SQL-RC-E108	       PIC S9(4) COMP-5 VALUE -108.
* clause not permitted
 77  SQL-RC-E109	       PIC S9(4) COMP-5 VALUE -109.
* invalid hex constant
 77  SQL-RC-E110	       PIC S9(4) COMP-5 VALUE -110.
* no column name
 77  SQL-RC-E111	       PIC S9(4) COMP-5 VALUE -111.
* operand is SQL function
 77  SQL-RC-E112	       PIC S9(4) COMP-5 VALUE -112.
* wrong nbr of insert values
 77  SQL-RC-E117	       PIC S9(4) COMP-5 VALUE -117.
* object table in from clause
 77  SQL-RC-E118	       PIC S9(4) COMP-5 VALUE -118.
* column not in group by
 77  SQL-RC-E119	       PIC S9(4) COMP-5 VALUE -119.
* clause includes SQL fn
 77  SQL-RC-E120	       PIC S9(4) COMP-5 VALUE -120.
* dup column name
 77  SQL-RC-E121	       PIC S9(4) COMP-5 VALUE -121.
* no group by
 77  SQL-RC-E122	       PIC S9(4) COMP-5 VALUE -122.
* parameter must be constant
 77  SQL-RC-NOTCONST	       PIC S9(4) COMP-5 VALUE -123.
* no result column
 77  SQL-RC-E125	       PIC S9(4) COMP-5 VALUE -125.
* dup distinct
 77  SQL-RC-E127	       PIC S9(4) COMP-5 VALUE -127.
* too many table names
 77  SQL-RC-E129	       PIC S9(4) COMP-5 VALUE -129.
* invalid escape character
 77  SQL-RC-INVESC	       PIC S9(4) COMP-5 VALUE -130.
* incompatible data for like
 77  SQL-RC-E131	       PIC S9(4) COMP-5 VALUE -131.
* like predicate invalid
 77  SQL-RC-E132	       PIC S9(4) COMP-5 VALUE -132.
* improper use of long string
 77  SQL-RC-E134	       PIC S9(4) COMP-5 VALUE -134.
* length of concat too long
 77  SQL-RC-E137	       PIC S9(4) COMP-5 VALUE -137.
* substr arg out of range
 77  SQL-RC-E138	       PIC S9(4) COMP-5 VALUE -138.
* syntax not supported
 77  SQL-RC-E142	       PIC S9(4) COMP-5 VALUE -142.
* unsupported ANSI syntax
 77  SQL-RC-E146	       PIC S9(4) COMP-5 VALUE -146.
* view not updatable
 77  SQL-RC-E150	       PIC S9(4) COMP-5 VALUE -150.
* column not updatable
 77  SQL-RC-E151	       PIC S9(4) COMP-5 VALUE -151.
* no column list
 77  SQL-RC-E153	       PIC S9(4) COMP-5 VALUE -153.
* trigger trans tbl not modifiable
 77  SQL-RC-E155	       PIC S9(4) COMP-5 VALUE -155.
* command not allowed on view
 77  SQL-RC-E156	       PIC S9(4) COMP-5 VALUE -156.
* view name in foreign key
 77  SQL-RC-E157	       PIC S9(4) COMP-5 VALUE -157.
* nbr of columns does not match
 77  SQL-RC-E158	       PIC S9(4) COMP-5 VALUE -158.
* drop view on table
 77  SQL-RC-E159	       PIC S9(4) COMP-5 VALUE -159.
* with check not allowed on view
 77  SQL-RC-E160	       PIC S9(4) COMP-5 VALUE -160.
* with check violation
 77  SQL-RC-E161	       PIC S9(4) COMP-5 VALUE -161.
* nbr of arguments invalid
 77  SQL-RC-E170	       PIC S9(4) COMP-5 VALUE -170.
* argument invalid
 77  SQL-RC-E171	       PIC S9(4) COMP-5 VALUE -171.
* function name invalid
 77  SQL-RC-E172	       PIC S9(4) COMP-5 VALUE -172.
* translate scalar argument invalid
 77  SQL-RC-E176	       PIC S9(4) COMP-5 VALUE -176.
* datetime syntax invalid
 77  SQL-RC-E180	       PIC S9(4) COMP-5 VALUE -180.
* datetime value invalid
 77  SQL-RC-E181	       PIC S9(4) COMP-5 VALUE -181.
* datetime arithmetic invalid
 77  SQL-RC-E182	       PIC S9(4) COMP-5 VALUE -182.
* datetime arithmetic out of range
 77  SQL-RC-E183	       PIC S9(4) COMP-5 VALUE -183.
* datetime register is invalid
 77  SQL-RC-DTMEREG	       PIC S9(4) COMP-5 VALUE -187.
* truncated DBCS character found
 77  SQL-RC-DBCSTRUNC	       PIC S9(4) COMP-5 VALUE -191.
* NOT NULL needs DEFAULT
 77  SQL-RC-E193	       PIC S9(4) COMP-5 VALUE -193.
* no qualified columns in ORDER BY
 77  SQL-RC-E197	       PIC S9(4) COMP-5 VALUE -197.
* no statement text
 77  SQL-RC-E198	       PIC S9(4) COMP-5 VALUE -198.
* illegal use of reserved word
 77  SQL-RC-E199	       PIC S9(4) COMP-5 VALUE -199.

* ambiguous column reference
 77  SQL-RC-E203	       PIC S9(4) COMP-5 VALUE -203.
* undefined name
 77  SQL-RC-E204	       PIC S9(4) COMP-5 VALUE -204.
* not a column
 77  SQL-RC-E205	       PIC S9(4) COMP-5 VALUE -205.
* not a column of referenced tables
 77  SQL-RC-E206	       PIC S9(4) COMP-5 VALUE -206.
* cannot orderby column name w/union
 77  SQL-RC-E207	       PIC S9(4) COMP-5 VALUE -207.
* column not part of result table
 77  SQL-RC-E208	       PIC S9(4) COMP-5 VALUE -208.
* duplicate table designator
 77  SQL-RC-E212	       PIC S9(4) COMP-5 VALUE -212.
* required explain table not exist
 77  SQL-RC-E219	       PIC S9(4) COMP-5 VALUE -219.
* bad expression in group/by or order by
 77  SQL-RC-E214	       PIC S9(4) COMP-5 VALUE -214.
* explain table has improper def
 77  SQL-RC-E220	       PIC S9(4) COMP-5 VALUE -220.
* raw device containers not allowed
 77  SQL-RC-E257	       PIC S9(4) COMP-5 VALUE -257.
* cannot add container to pool
 77  SQL-RC-E258	       PIC S9(4) COMP-5 VALUE -258.
* container map too big
 77  SQL-RC-E259	       PIC S9(4) COMP-5 VALUE -259.
* cannot add containers to tablespace
 77  SQL-RC-E281	       PIC S9(4) COMP-5 VALUE -281.
* cannot drop tblspace, tbl conflict
 77  SQL-RC-E282	       PIC S9(4) COMP-5 VALUE -282.
* cannot drop only temp tablespace
 77  SQL-RC-E283	       PIC S9(4) COMP-5 VALUE -283.
* invalid tablespace type for clause
 77  SQL-RC-E284	       PIC S9(4) COMP-5 VALUE -284.
* all table parts must be in tblspce
 77  SQL-RC-E285	       PIC S9(4) COMP-5 VALUE -285.
* need default tblspce for new tables
 77  SQL-RC-E286	       PIC S9(4) COMP-5 VALUE -286.
* SYSCATSPACE not for user objects
 77  SQL-RC-E287	       PIC S9(4) COMP-5 VALUE -287.
* long tablespace cannot use system
 77  SQL-RC-E288	       PIC S9(4) COMP-5 VALUE -288.
* cannot allocate new pages in tablespace
 77  SQL-RC-E289	       PIC S9(4) COMP-5 VALUE -289.
* access to tablespace not allowed
 77  SQL-RC-E290	       PIC S9(4) COMP-5 VALUE -290.
* invalid state transition
 77  SQL-RC-E291	       PIC S9(4) COMP-5 VALUE -291.
* cannot create internal db file
 77  SQL-RC-E292	       PIC S9(4) COMP-5 VALUE -292.
* error accessing container
 77  SQL-RC-E293	       PIC S9(4) COMP-5 VALUE -293.
* container already in use
 77  SQL-RC-E294	       PIC S9(4) COMP-5 VALUE -294.
* container names too long
 77  SQL-RC-E295	       PIC S9(4) COMP-5 VALUE -295.
* tablespace limit exceeded
 77  SQL-RC-E296	       PIC S9(4) COMP-5 VALUE -296.
* container pathname too long
 77  SQL-RC-E297	       PIC S9(4) COMP-5 VALUE -297.
* bad container pathname
 77  SQL-RC-E298	       PIC S9(4) COMP-5 VALUE -298.
* container already added
 77  SQL-RC-E299	       PIC S9(4) COMP-5 VALUE -299.

* host variable has invalid type
 77  SQL-RC-E301	       PIC S9(4) COMP-5 VALUE -301.
* host variable value too large
 77  SQL-RC-E302	       PIC S9(4) COMP-5 VALUE -302.
* data types not comparable
 77  SQL-RC-E303	       PIC S9(4) COMP-5 VALUE -303.
* value not in range of host var
 77  SQL-RC-E304	       PIC S9(4) COMP-5 VALUE -304.
* host var cannot be null
 77  SQL-RC-E305	       PIC S9(4) COMP-5 VALUE -305.
* host var limit reached
 77  SQL-RC-E308	       PIC S9(4) COMP-5 VALUE -308.
* host var should not be null
 77  SQL-RC-E309	       PIC S9(4) COMP-5 VALUE -309.
* length of host var is negative
 77  SQL-RC-E311	       PIC S9(4) COMP-5 VALUE -311.
* unusable host variable
 77  SQL-RC-E312	       PIC S9(4) COMP-5 VALUE -312.
* wrong nbr of host variables
 77  SQL-RC-E313	       PIC S9(4) COMP-5 VALUE -313.
* no conversn source-cp to target-cp
 77  SQL-RC-E332	       PIC S9(4) COMP-5 VALUE -332.
* converion overflow
 77  SQL-RC-E334	       PIC S9(4) COMP-5 VALUE -334.
* duplicate common table expression
 77  SQL-RC-E340	       PIC S9(4) COMP-5 VALUE -340.
* cyclic ref between comm tbl exp
 77  SQL-RC-E341	       PIC S9(4) COMP-5 VALUE -341.
* comm tbl exp use UNION ALL
 77  SQL-RC-E342	       PIC S9(4) COMP-5 VALUE -342.
* col names required
 77  SQL-RC-E343	       PIC S9(4) COMP-5 VALUE -343.
* columns must match exactly
 77  SQL-RC-E344	       PIC S9(4) COMP-5 VALUE -344.
* cannot use GROUP BY or HAVING here
 77  SQL-RC-E345	       PIC S9(4) COMP-5 VALUE -345.
* invalid reference to comm tbl exp
 77  SQL-RC-E346	       PIC S9(4) COMP-5 VALUE -346.
* LOB col cannot be idx, key, constr
 77  SQL-RC-E350	       PIC S9(4) COMP-5 VALUE -350.
* LOB col cannot be selected by DRDA
 77  SQL-RC-E351	       PIC S9(4) COMP-5 VALUE -351.
* LOB col cannot be inserted by DRDA
 77  SQL-RC-E352	       PIC S9(4) COMP-5 VALUE -352.
* LOB col cannot be logged
 77  SQL-RC-E355	       PIC S9(4) COMP-5 VALUE -355.

* operands not comparable
 77  SQL-RC-E401	       PIC S9(4) COMP-5 VALUE -401.
* invalid type for arithmetic op
 77  SQL-RC-E402	       PIC S9(4) COMP-5 VALUE -402.
* alias object undefined
 77  SQL-RC-E403	       PIC S9(4) COMP-5 VALUE -403.
* update/insert string too long
 77  SQL-RC-E404	       PIC S9(4) COMP-5 VALUE -404.
* numeric literal out of range
 77  SQL-RC-E405	       PIC S9(4) COMP-5 VALUE -405.
* derived value out of range
 77  SQL-RC-E406	       PIC S9(4) COMP-5 VALUE -406.
* column cannot be null
 77  SQL-RC-E407	       PIC S9(4) COMP-5 VALUE -407.
* invalid data type for column
 77  SQL-RC-E408	       PIC S9(4) COMP-5 VALUE -408.
* invalid operand for count
 77  SQL-RC-E409	       PIC S9(4) COMP-5 VALUE -409.
* float literal too long
 77  SQL-RC-E410	       PIC S9(4) COMP-5 VALUE -410.
* multiple columns in subquery
 77  SQL-RC-E412	       PIC S9(4) COMP-5 VALUE -412.
* overflow during data conversion
 77  SQL-RC-E413	       PIC S9(4) COMP-5 VALUE -413.
* incompatible data types for union
 77  SQL-RC-E415	       PIC S9(4) COMP-5 VALUE -415.
* long string in union
 77  SQL-RC-E416	       PIC S9(4) COMP-5 VALUE -416.
* invalid use of parameter markers
 77  SQL-RC-E417	       PIC S9(4) COMP-5 VALUE -417.
* parameter marker in select clause
 77  SQL-RC-E418	       PIC S9(4) COMP-5 VALUE -418.
* division produced negative scale
 77  SQL-RC-E419	       PIC S9(4) COMP-5 VALUE -419.
* invalid character in input string
 77  SQL-RC-E420	       PIC S9(4) COMP-5 VALUE -420.
* diff number of columns for union
 77  SQL-RC-E421	       PIC S9(4) COMP-5 VALUE -421.
* Invalid handle
 77  SQL-RC-E423	       PIC S9(4) COMP-5 VALUE -423.
* dynamic COMMIT not valid
 77  SQL-RC-E426	       PIC S9(4) COMP-5 VALUE -426.
* dynamic ROLLBACK not valid
 77  SQL-RC-E427	       PIC S9(4) COMP-5 VALUE -427.
* DISCONNECT in unit of work notallow
 77  SQL-RC-E428	       PIC S9(4) COMP-5 VALUE -428.
* Handle table full
 77  SQL-RC-E429	       PIC S9(4) COMP-5 VALUE -429.
* UDF abnormal end
 77  SQL-RC-E430	       PIC S9(4) COMP-5 VALUE -430.
* UDF interrupted
 77  SQL-RC-E431	       PIC S9(4) COMP-5 VALUE -431.
* Parameter marker cannot have udf nm
 77  SQL-RC-E432	       PIC S9(4) COMP-5 VALUE -432.
* Value is too long
 77  SQL-RC-E433	       PIC S9(4) COMP-5 VALUE -433.
* Inv SQLSTATE in RAISE_ERROR
 77  SQL-RC-E435	       PIC S9(4) COMP-5 VALUE -435.
* C language char string missing NUL
 77  SQL-RC-E436	       PIC S9(4) COMP-5 VALUE -436.
* App raised error
 77  SQL-RC-E438	       PIC S9(4) COMP-5 VALUE -438.
* Error in UDF
 77  SQL-RC-E439	       PIC S9(4) COMP-5 VALUE -439.
* No function with compatible arg
 77  SQL-RC-E440	       PIC S9(4) COMP-5 VALUE -440.
* Invalid use of DISTINCT with scalar
 77  SQL-RC-E441	       PIC S9(4) COMP-5 VALUE -441.
* Error refering function in DML
 77  SQL-RC-E442	       PIC S9(4) COMP-5 VALUE -442.
* UDF returns error sqlstate
 77  SQL-RC-E443	       PIC S9(4) COMP-5 VALUE -443.
* Unable to access UDF function
 77  SQL-RC-E444	       PIC S9(4) COMP-5 VALUE -444.
* Exceed max number of parameters
 77  SQL-RC-E448	       PIC S9(4) COMP-5 VALUE -448.
* Invalid EXTERNAL NAME format
 77  SQL-RC-E449	       PIC S9(4) COMP-5 VALUE -449.
* UDF generates too long result value
 77  SQL-RC-E450	       PIC S9(4) COMP-5 VALUE -450.
* DDL: invalid type for external UDF
 77  SQL-RC-E451	       PIC S9(4) COMP-5 VALUE -451.
* Hostvar file inaccessible
 77  SQL-RC-E452	       PIC S9(4) COMP-5 VALUE -452.
* Error in RETURNS and CAST FROM
 77  SQL-RC-E453	       PIC S9(4) COMP-5 VALUE -453.
* Duplicate UDF name and signature
 77  SQL-RC-E454	       PIC S9(4) COMP-5 VALUE -454.
* Diff schema for UDF name & specific
 77  SQL-RC-E455	       PIC S9(4) COMP-5 VALUE -455.
* Duplicate specific name
 77  SQL-RC-E456	       PIC S9(4) COMP-5 VALUE -456.
* Name reserved for system use
 77  SQL-RC-E457	       PIC S9(4) COMP-5 VALUE -457.
* DDL refers UDF signature not found
 77  SQL-RC-E458	       PIC S9(4) COMP-5 VALUE -458.
* AS CAST use error
 77  SQL-RC-E459	       PIC S9(4) COMP-5 VALUE -459.
* invalid CAST
 77  SQL-RC-E461	       PIC S9(4) COMP-5 VALUE -461.
* UDF returns an invalid sqlstate
 77  SQL-RC-E463	       PIC S9(4) COMP-5 VALUE -463.
* Unable to start fenced UDF
 77  SQL-RC-E465	       PIC S9(4) COMP-5 VALUE -465.
* reserved object name
 77  SQL-RC-E473	       PIC S9(4) COMP-5 VALUE -473.
* Result type of source is different
 77  SQL-RC-E475	       PIC S9(4) COMP-5 VALUE -475.
* Reference to function is not unique
 77  SQL-RC-E476	       PIC S9(4) COMP-5 VALUE -476.
* other obj depends on this obj
 77  SQL-RC-E478	       PIC S9(4) COMP-5 VALUE -478.
* Parm num not match with source
 77  SQL-RC-E483	       PIC S9(4) COMP-5 VALUE -483.
* Boolean type is system used only
 77  SQL-RC-E486	       PIC S9(4) COMP-5 VALUE -486.
* Attempt to excute an SQL statement
 77  SQL-RC-E487	       PIC S9(4) COMP-5 VALUE -487.
* Inv BOOLEAN in select list result
 77  SQL-RC-E489	       PIC S9(4) COMP-5 VALUE -489.
* DDL: missing reqired clause
 77  SQL-RC-E491	       PIC S9(4) COMP-5 VALUE -491.
* DDL: miss match with source type
 77  SQL-RC-E492	       PIC S9(4) COMP-5 VALUE -492.
* UDF returned bad date/time value
 77  SQL-RC-E493	       PIC S9(4) COMP-5 VALUE -493.

* cursor not open (fetch/close)
 77  SQL-RC-E501	       PIC S9(4) COMP-5 VALUE -501.
* cursor already open
 77  SQL-RC-E502	       PIC S9(4) COMP-5 VALUE -502.
* column not in update clause
 77  SQL-RC-E503	       PIC S9(4) COMP-5 VALUE -503.
* cursor name not defined
 77  SQL-RC-E504	       PIC S9(4) COMP-5 VALUE -504.
* cursor not open (update/delete)
 77  SQL-RC-E507	       PIC S9(4) COMP-5 VALUE -507.
* cursor not on a row
 77  SQL-RC-E508	       PIC S9(4) COMP-5 VALUE -508.
* table not same as for cursor
 77  SQL-RC-E509	       PIC S9(4) COMP-5 VALUE -509.
* table cannot be modified
 77  SQL-RC-E510	       PIC S9(4) COMP-5 VALUE -510.
* for update not allowed
 77  SQL-RC-E511	       PIC S9(4) COMP-5 VALUE -511.
* cursor not prepared
 77  SQL-RC-E514	       PIC S9(4) COMP-5 VALUE -514.
* describe not a prepared statement
 77  SQL-RC-E516	       PIC S9(4) COMP-5 VALUE -516.
* prepared statment not a select
 77  SQL-RC-E517	       PIC S9(4) COMP-5 VALUE -517.
* execute not a prepared statement
 77  SQL-RC-E518	       PIC S9(4) COMP-5 VALUE -518.
* statement has an open cursor
 77  SQL-RC-E519	       PIC S9(4) COMP-5 VALUE -519.
* invalid foreign key value
 77  SQL-RC-E530	       PIC S9(4) COMP-5 VALUE -530.
* cannot update primary key
 77  SQL-RC-E531	       PIC S9(4) COMP-5 VALUE -531.
* delete is restricted
 77  SQL-RC-E532	       PIC S9(4) COMP-5 VALUE -532.
* multi-row insert not allowed
 77  SQL-RC-E533	       PIC S9(4) COMP-5 VALUE -533.
* multi-row update of pk
 77  SQL-RC-E534	       PIC S9(4) COMP-5 VALUE -534.
* multi-row delete not allowed
 77  SQL-RC-E535	       PIC S9(4) COMP-5 VALUE -535.
* descendent in subquery
 77  SQL-RC-E536	       PIC S9(4) COMP-5 VALUE -536.
* dup column in key def
 77  SQL-RC-E537	       PIC S9(4) COMP-5 VALUE -537.
* foreign key does not match pk
 77  SQL-RC-E538	       PIC S9(4) COMP-5 VALUE -538.
* table does not have primary key
 77  SQL-RC-E539	       PIC S9(4) COMP-5 VALUE -539.
* duplicate referential constraint
 77  SQL-RC-E541	       PIC S9(4) COMP-5 VALUE -541.
* pk column cannot allow nulls
 77  SQL-RC-E542	       PIC S9(4) COMP-5 VALUE -542.
* restricted row delete
 77  SQL-RC-E543	       PIC S9(4) COMP-5 VALUE -543.
* check contraint violated
 77  SQL-RC-E544	       PIC S9(4) COMP-5 VALUE -544.
* check contraint not satisfied
 77  SQL-RC-E545	       PIC S9(4) COMP-5 VALUE -545.
* check contraint invalid
 77  SQL-RC-E546	       PIC S9(4) COMP-5 VALUE -546.
* check contraint invalid
 77  SQL-RC-E548	       PIC S9(4) COMP-5 VALUE -548.
* authorization error w/obj insert
 77  SQL-RC-E551	       PIC S9(4) COMP-5 VALUE -551.
* auth error w/o obj ins
 77  SQL-RC-E552	       PIC S9(4) COMP-5 VALUE -552.
* SYSIBM qualifier
 77  SQL-RC-E553	       PIC S9(4) COMP-5 VALUE -553.
* cannot grant privilege to self
 77  SQL-RC-E554	       PIC S9(4) COMP-5 VALUE -554.
* cannot revoke privilege from self
 77  SQL-RC-E555	       PIC S9(4) COMP-5 VALUE -555.
* revoke stmt denied--priv not held
 77  SQL-RC-E556	       PIC S9(4) COMP-5 VALUE -556.
* invalid combination of privileges
 77  SQL-RC-E557	       PIC S9(4) COMP-5 VALUE -557.
* revoke stmt denied--has CONTROL
 77  SQL-RC-E558	       PIC S9(4) COMP-5 VALUE -558.
* privilege not allowed for public
 77  SQL-RC-E562	       PIC S9(4) COMP-5 VALUE -562.
* invalid authorization id
 77  SQL-RC-E567	       PIC S9(4) COMP-5 VALUE -567.
* user/group ambiguity
 77  SQL-RC-E569	       PIC S9(4) COMP-5 VALUE -569.
* Inoperative package
 77  SQL-RC-E572	       PIC S9(4) COMP-5 VALUE -572.
* contraint col not primary key
 77  SQL-RC-E573	       PIC S9(4) COMP-5 VALUE -573.
* DEFAULT invalid for column
 77  SQL-RC-E574	       PIC S9(4) COMP-5 VALUE -574.
* view is inoperative
 77  SQL-RC-E575	       PIC S9(4) COMP-5 VALUE -575.
* Repetitive alias chain
 77  SQL-RC-E576	       PIC S9(4) COMP-5 VALUE -576.
* Result of CASE expr cannot be NULL
 77  SQL-RC-E580	       PIC S9(4) COMP-5 VALUE -580.
* Data types of CASE expr incompat
 77  SQL-RC-E581	       PIC S9(4) COMP-5 VALUE -581.
* Inv predicate in CASE expr
 77  SQL-RC-E582	       PIC S9(4) COMP-5 VALUE -582.
* Variant or ext action function
 77  SQL-RC-E583	       PIC S9(4) COMP-5 VALUE -583.
* Inv use of NULL or DEFAULT
 77  SQL-RC-E584	       PIC S9(4) COMP-5 VALUE -584.
* Duplicate schema name
 77  SQL-RC-E585	       PIC S9(4) COMP-5 VALUE -585.
* Too many schema names
 77  SQL-RC-E586	       PIC S9(4) COMP-5 VALUE -586.
* udf - dup func signature
 77  SQL-RC-E600	       PIC S9(4) COMP-5 VALUE -600.
* duplicate table/view name
 77  SQL-RC-E601	       PIC S9(4) COMP-5 VALUE -601.
* too many columns in index
 77  SQL-RC-E602	       PIC S9(4) COMP-5 VALUE -602.
* cannot create unique index
 77  SQL-RC-E603	       PIC S9(4) COMP-5 VALUE -603.
* invalid length, precision, scale
 77  SQL-RC-E604	       PIC S9(4) COMP-5 VALUE -604.
* op not allowed on system tables
 77  SQL-RC-E607	       PIC S9(4) COMP-5 VALUE -607.
* duplicate column name
 77  SQL-RC-E612	       PIC S9(4) COMP-5 VALUE -612.
* primary key too long
 77  SQL-RC-E613	       PIC S9(4) COMP-5 VALUE -613.
* index key too long
 77  SQL-RC-E614	       PIC S9(4) COMP-5 VALUE -614.
* table already has primary key
 77  SQL-RC-E624	       PIC S9(4) COMP-5 VALUE -624.
* DDL: multiple/conflict keywords
 77  SQL-RC-E628	       PIC S9(4) COMP-5 VALUE -628.
* foreign key is not nullable
 77  SQL-RC-E629	       PIC S9(4) COMP-5 VALUE -629.
* foreign key is too long
 77  SQL-RC-E631	       PIC S9(4) COMP-5 VALUE -631.
* delete rule restriction
 77  SQL-RC-E632	       PIC S9(4) COMP-5 VALUE -632.
* delete rule is restricted
 77  SQL-RC-E633	       PIC S9(4) COMP-5 VALUE -633.
* delete rule cannot be CASCADE
 77  SQL-RC-E634	       PIC S9(4) COMP-5 VALUE -634.
* dup pk or drop pk clause
 77  SQL-RC-E637	       PIC S9(4) COMP-5 VALUE -637.
* no column definitions
 77  SQL-RC-E638	       PIC S9(4) COMP-5 VALUE -638.
* invalid keyword value
 77  SQL-RC-E644	       PIC S9(4) COMP-5 VALUE -644.
* architectural size limit of object
 77  SQL-RC-E659	       PIC S9(4) COMP-5 VALUE -659.
* ref constraint does not hold
 77  SQL-RC-E667	       PIC S9(4) COMP-5 VALUE -667.
* table in CHECK PENDING state
 77  SQL-RC-E668	       PIC S9(4) COMP-5 VALUE -668.
* cannot drop primary key
 77  SQL-RC-E669	       PIC S9(4) COMP-5 VALUE -669.
* row length too large
 77  SQL-RC-E670	       PIC S9(4) COMP-5 VALUE -670.
* primary key not unique
 77  SQL-RC-E673	       PIC S9(4) COMP-5 VALUE -673.
* too many columns for table
 77  SQL-RC-E680	       PIC S9(4) COMP-5 VALUE -680.
* incompatible column constraint
 77  SQL-RC-E683	       PIC S9(4) COMP-5 VALUE -683.
* invalid trigger definition
 77  SQL-RC-E696	       PIC S9(4) COMP-5 VALUE -696.
* invalid correlation name use
 77  SQL-RC-E697	       PIC S9(4) COMP-5 VALUE -697.

* object uses reserved name
 77  SQL-RC-E707	       PIC S9(4) COMP-5 VALUE -707.
* invalid replace value for sp reg
 77  SQL-RC-INV-REPL	       PIC S9(4) COMP-5 VALUE -713.
* trigger error
 77  SQL-RC-E723	       PIC S9(4) COMP-5 VALUE -723.
* max level of cascading
 77  SQL-RC-E724	       PIC S9(4) COMP-5 VALUE -724.
* Invalid triggered statement
 77  SQL-RC-E751	       PIC S9(4) COMP-5 VALUE -751.
* Inoperative package
 77  SQL-RC-E752	       PIC S9(4) COMP-5 VALUE -752.
* rename table error
 77  SQL-RC-E750	       PIC S9(4) COMP-5 VALUE -750.

* divide by zero
 77  SQL-RC-E801	       PIC S9(4) COMP-5 VALUE -801.
* arith overflow or divide by zero
 77  SQL-RC-E802	       PIC S9(4) COMP-5 VALUE -802.
* distinct violation
 77  SQL-RC-E803	       PIC S9(4) COMP-5 VALUE -803.
* bad input parameters
 77  SQL-RC-E804	       PIC S9(4) COMP-5 VALUE -804.
* program not bound
 77  SQL-RC-E805	       PIC S9(4) COMP-5 VALUE -805.
* inconsistent connect semantics
 77  SQL-RC-E808	       PIC S9(4) COMP-5 VALUE -808.
* more than one row/value
 77  SQL-RC-E811	       PIC S9(4) COMP-5 VALUE -811.
* time stamp conflict
 77  SQL-RC-E818	       PIC S9(4) COMP-5 VALUE -818.
* invalid address in sqlda
 77  SQL-RC-E822	       PIC S9(4) COMP-5 VALUE -822.
* too many items in list
 77  SQL-RC-E840	       PIC S9(4) COMP-5 VALUE -840.
* connection already exists
 77  SQL-RC-E842	       PIC S9(4) COMP-5 VALUE -842.
* connection does not exist
 77  SQL-RC-E843	       PIC S9(4) COMP-5 VALUE -843.
* can't change connection settings
 77  SQL-RC-E847	       PIC S9(4) COMP-5 VALUE -847.
* TM not for 2 phase commit apps
 77  SQL-RC-E859	       PIC S9(4) COMP-5 VALUE -859.
* inv TM_DATABASE value
 77  SQL-RC-E865	       PIC S9(4) COMP-5 VALUE -865.
* connect redirect failed
 77  SQL-RC-E866	       PIC S9(4) COMP-5 VALUE -866.
* connection already exists
 77  SQL-RC-E868	       PIC S9(4) COMP-5 VALUE -868.

* non-fatal system error
 77  SQL-RC-E901	       PIC S9(4) COMP-5 VALUE -901.
* fatal error
 77  SQL-RC-E902	       PIC S9(4) COMP-5 VALUE -902.
* commit failed, rollback
 77  SQL-RC-E903	       PIC S9(4) COMP-5 VALUE -903.
* lock timeout
 77  SQL-RC-E904	       PIC S9(4) COMP-5 VALUE -904.
* drop pending
 77  SQL-RC-E910	       PIC S9(4) COMP-5 VALUE -910.
* deadlock
 77  SQL-RC-E911	       PIC S9(4) COMP-5 VALUE -911.
* too many lock requests
 77  SQL-RC-E912	       PIC S9(4) COMP-5 VALUE -912.
* dist env rollback
 77  SQL-RC-E913	       PIC S9(4) COMP-5 VALUE -913.
* ROLLBACK required
 77  SQL-RC-E918	       PIC S9(4) COMP-5 VALUE -918.
* reject DB connection to SA REQ
 77  SQL-RC-E920	       PIC S9(4) COMP-5 VALUE -920.
* COMMIT not allowed
 77  SQL-RC-E925	       PIC S9(4) COMP-5 VALUE -925.
* ROLLBACK not allowed
 77  SQL-RC-E926	       PIC S9(4) COMP-5 VALUE -926.
* insufficient storage
 77  SQL-RC-E930	       PIC S9(4) COMP-5 VALUE -930.
* all inodes used, system limit
 77  SQL-RC-INODE	       PIC S9(4) COMP-5 VALUE -931.
* cursors active on dropped object
 77  SQL-RC-E950	       PIC S9(4) COMP-5 VALUE -950.
* table in use - alter disallowed
 77  SQL-RC-E951	       PIC S9(4) COMP-5 VALUE -951.
* user cancel
 77  SQL-RC-E952	       PIC S9(4) COMP-5 VALUE -952.
* agent heap too small
 77  SQL-RC-E953	       PIC S9(4) COMP-5 VALUE -953.
* application heap too small
 77  SQL-RC-E954	       PIC S9(4) COMP-5 VALUE -954.
* sort heap error
 77  SQL-RC-E955	       PIC S9(4) COMP-5 VALUE -955.
* database heap too small
 77  SQL-RC-E956	       PIC S9(4) COMP-5 VALUE -956.
* requestor comm heap too small
 77  SQL-RC-E957	       PIC S9(4) COMP-5 VALUE -957.
* max number of files open
 77  SQL-RC-E958	       PIC S9(4) COMP-5 VALUE -958.
* server comm heap too small
 77  SQL-RC-E959	       PIC S9(4) COMP-5 VALUE -959.
* max nbr of files in database
 77  SQL-RC-E960	       PIC S9(4) COMP-5 VALUE -960.
* rqstr remote svcs heap too small
 77  SQL-RC-E961	       PIC S9(4) COMP-5 VALUE -961.
* svr remote svcs heap too small
 77  SQL-RC-E962	       PIC S9(4) COMP-5 VALUE -962.
* log file full
 77  SQL-RC-E964	       PIC S9(4) COMP-5 VALUE -964.
* error opening sqlcode mapping file
 77  SQL-RC-E966	       PIC S9(4) COMP-5 VALUE -966.
* format error in sqlcode map file
 77  SQL-RC-E967	       PIC S9(4) COMP-5 VALUE -967.
* disk full
 77  SQL-RC-E968	       PIC S9(4) COMP-5 VALUE -968.
* unknown sql error another product
 77  SQL-RC-E969	       PIC S9(4) COMP-5 VALUE -969.
* read-only file
 77  SQL-RC-E970	       PIC S9(4) COMP-5 VALUE -970.

* incorrect diskette
 77  SQL-RC-E972-DB2AIX        PIC S9(9) COMP-5 VALUE -10019.
* incorrect diskette
 77  SQL-RC-E972-DB2OS2        PIC S9(4) COMP-5 VALUE -972.
* incorrect diskette
 77  SQL-RC-E972	       PIC S9(4) COMP-5 VALUE -972.

* out of memory error
 77  SQL-RC-E973	       PIC S9(4) COMP-5 VALUE -973.

* drive locked
 77  SQL-RC-E974-DB2AIX        PIC S9(9) COMP-5 VALUE -10019.
* drive locked
 77  SQL-RC-E974-DB2OS2        PIC S9(4) COMP-5 VALUE -974.
* drive locked
 77  SQL-RC-E974	       PIC S9(4) COMP-5 VALUE -974.

* quiesce backup
 77  SQL-RC-QBACK	       PIC S9(4) COMP-5 VALUE -975.

* diskette door open
 77  SQL-RC-E976-DB2AIX        PIC S9(9) COMP-5 VALUE -10019.
* diskette door open
 77  SQL-RC-E976-DB2OS2        PIC S9(4) COMP-5 VALUE -976.
* diskette door open
 77  SQL-RC-E976	       PIC S9(4) COMP-5 VALUE -976.

* unknown commit state
 77  SQL-RC-E977	       PIC S9(4) COMP-5 VALUE -977.
* diskette write-protected
 77  SQL-RC-E978-DB2AIX        PIC S9(9) COMP-5 VALUE -10019.
* diskette write-protected
 77  SQL-RC-E978-DB2OS2        PIC S9(4) COMP-5 VALUE -978.
* diskette write-protected
 77  SQL-RC-E978	       PIC S9(4) COMP-5 VALUE -978.

* commit failed with SYNCPOINT NONE
 77  SQL-RC-E979	       PIC S9(4) COMP-5 VALUE -979.
* disk error
 77  SQL-RC-E980	       PIC S9(4) COMP-5 VALUE -980.
* disk error on temp file
 77  SQL-RC-E982	       PIC S9(4) COMP-5 VALUE -982.
* unsuccessful commit or rollback
 77  SQL-RC-E984	       PIC S9(4) COMP-5 VALUE -984.
* file error - catalog file bad
 77  SQL-RC-E985	       PIC S9(4) COMP-5 VALUE -985.
* file error - file renamed
 77  SQL-RC-E986	       PIC S9(4) COMP-5 VALUE -986.
* app ctl heap out of memory
 77  SQL-RC-E988	       PIC S9(4) COMP-5 VALUE -988.
* index structure limit error
 77  SQL-RC-E990	       PIC S9(4) COMP-5 VALUE -990.
* release number incompatible
 77  SQL-RC-E992	       PIC S9(4) COMP-5 VALUE -992.
* reserved
 77  SQL-RC-E994	       PIC S9(4) COMP-5 VALUE -994.
* error freeing pages in DMS tablespace
 77  SQL-RC-E996	       PIC S9(4) COMP-5 VALUE -996.
* General XA error
 77  SQL-RC-E998	       PIC S9(4) COMP-5 VALUE -998.

* error finding pages in DMS tablespace
 77  SQL-RC-E1007	       PIC S9(4) COMP-5 VALUE -1007.
* invalid tablespace id
 77  SQL-RC-E1008	       PIC S9(4) COMP-5 VALUE -1008.

* invalid use of graphic data
 77  SQL-RC-E1216	       PIC S9(4) COMP-5 VALUE -1216.
* out of private memory
 77  SQL-RC-E1219	       PIC S9(4) COMP-5 VALUE -1219.
* Updatale cat values inv
 77  SQL-RC-E1227	       PIC S9(4) COMP-5 VALUE -1227.
* System error rollback
 77  SQL-RC-E1229	       PIC S9(4) COMP-5 VALUE -1229.
* Disconn at next commit
 77  SQL-RC-W1244	       PIC S9(4) COMP-5 VALUE 1244.
* Max client connects
 77  SQL-RC-E1245	       PIC S9(4) COMP-5 VALUE -1245.
* XA TM uses syncpoint 2
 77  SQL-RC-E1247	       PIC S9(4) COMP-5 VALUE -1247.
* db not defined with TM
 77  SQL-RC-E1248	       PIC S9(4) COMP-5 VALUE -1248.
* DB2CLIENTCOMM env var inv
 77  SQL-RC-E1290	       PIC S9(4) COMP-5 VALUE -1290.
* direcory services error
 77  SQL-RC-E1291	       PIC S9(4) COMP-5 VALUE -1291.
* global dir error
 77  SQL-RC-E1293	       PIC S9(4) COMP-5 VALUE -1293.
* global dir path invalid
 77  SQL-RC-E1294	       PIC S9(4) COMP-5 VALUE -1294.
* global dir router invalid
 77  SQL-RC-E1295	       PIC S9(4) COMP-5 VALUE -1295.

* Not Atomic Compound SQL error(s)
 77  SQL-RC-E1339	       PIC S9(4) COMP-5 VALUE -1339.

* package not executable
 77  SQL-RC-E1419	       PIC S9(4) COMP-5 VALUE -1419.
* too many concat operators
 77  SQL-RC-E1420	       PIC S9(4) COMP-5 VALUE -1420.
* MBCS conversion error
 77  SQL-RC-E1421	       PIC S9(4) COMP-5 VALUE -1421.
* Container wrong size
 77  SQL-RC-E1422	       PIC S9(4) COMP-5 VALUE -1422.
* no blobs for dwn lvl cl
 77  SQL-RC-E1423	       PIC S9(4) COMP-5 VALUE -1423.
* too many transition tbles
 77  SQL-RC-E1424	       PIC S9(4) COMP-5 VALUE -1424.

* LONG not allowed on devices
 77  SQL-RC-E1590	       PIC S9(4) COMP-5 VALUE -1590.
* Table not in check pend state
 77  SQL-RC-E3600	       PIC S9(4) COMP-5 VALUE -3600.
* Auto Check pending state
 77  SQL-RC-W3601	       PIC S9(4) COMP-5 VALUE 3601.
* Constraint violation moved
 77  SQL-RC-W3602	       PIC S9(4) COMP-5 VALUE 3602.
* Constraint Violations
 77  SQL-RC-E3603	       PIC S9(4) COMP-5 VALUE -3603.
* Invalid Exception Table
 77  SQL-RC-E3604	       PIC S9(4) COMP-5 VALUE -3604.
* Exception Table same as Check Table
 77  SQL-RC-E3605	       PIC S9(4) COMP-5 VALUE -3605.
* # check & exception tables not match
 77  SQL-RC-E3606	       PIC S9(4) COMP-5 VALUE -3606.
* Parent in Check Pending state
 77  SQL-RC-E3608	       PIC S9(4) COMP-5 VALUE -3608.

* Java support not installed
 77  SQL-RC-E4300	       PIC S9(4) COMP-5 VALUE -4300.
* Java startup, comm, shutdown failed
 77  SQL-RC-E4301	       PIC S9(4) COMP-5 VALUE -4301.
* Java unclassificed exception
 77  SQL-RC-E4302	       PIC S9(4) COMP-5 VALUE -4302.
* Java cannot parse class!method
 77  SQL-RC-E4303	       PIC S9(4) COMP-5 VALUE -4303.
* Java cannot instantiate class
 77  SQL-RC-E4304	       PIC S9(4) COMP-5 VALUE -4304.
* Java internal error code
 77  SQL-RC-E4305	       PIC S9(4) COMP-5 VALUE -4305.
* Java cannot call method
 77  SQL-RC-E4306	       PIC S9(4) COMP-5 VALUE -4306.
* Java call problems
 77  SQL-RC-E4307	       PIC S9(4) COMP-5 VALUE -4307.
* DB2CLI.PROCEDURES has wrong schema
 77  SQL-RC-E4308	       PIC S9(4) COMP-5 VALUE -4308.

* Page number too high
 77  SQL-RC-E8100	       PIC S9(4) COMP-5 VALUE -8100.
* Segment in error
 77  SQL-RC-E8101	       PIC S9(4) COMP-5 VALUE -8101.

* Distribution protocol error, no disconnect
 77  SQL-RC-E30000	       PIC S9(9) COMP-5 VALUE -30000.
* Distribution protocol error, disconnect
 77  SQL-RC-E30020	       PIC S9(9) COMP-5 VALUE -30020.
* Distribution compatibility error
 77  SQL-RC-E30021	       PIC S9(9) COMP-5 VALUE -30021.
* Distribution memory allocation err
 77  SQL-RC-E30040	       PIC S9(9) COMP-5 VALUE -30040.
* Distribution memory allocation err, disconnect
 77  SQL-RC-E30041	       PIC S9(9) COMP-5 VALUE -30041.
* Invalid command while bind in prog
 77  SQL-RC-E30050	       PIC S9(9) COMP-5 VALUE -30050.
* Bind not active
 77  SQL-RC-E30051	       PIC S9(9) COMP-5 VALUE -30051.
* Bind Owner authorization failure
 77  SQL-RC-E30053	       PIC S9(9) COMP-5 VALUE -30053.
* RDB authorization failure
 77  SQL-RC-E30060	       PIC S9(9) COMP-5 VALUE -30060.
* RDB not found
 77  SQL-RC-E30061	       PIC S9(9) COMP-5 VALUE -30061.
* Distribution command error
 77  SQL-RC-E30070	       PIC S9(9) COMP-5 VALUE -30070.
* Distribution object error
 77  SQL-RC-E30071	       PIC S9(9) COMP-5 VALUE -30071.
* Distribution parameter error
 77  SQL-RC-E30072	       PIC S9(9) COMP-5 VALUE -30072.
* Distribution parameter value error
 77  SQL-RC-E30073	       PIC S9(9) COMP-5 VALUE -30073.
* Distribution reply error
 77  SQL-RC-E30074	       PIC S9(9) COMP-5 VALUE -30074.
* Communication error
 77  SQL-RC-E30080	       PIC S9(9) COMP-5 VALUE -30080.
* Communication error
 77  SQL-RC-E30081	       PIC S9(9) COMP-5 VALUE -30081.
* Security error
 77  SQL-RC-E30082	       PIC S9(9) COMP-5 VALUE -30082.
* Remote operation invalid
 77  SQL-RC-E30090	       PIC S9(9) COMP-5 VALUE -30090.
* Rebind options ignored
 77  SQL-RC-W30101	       PIC S9(9) COMP-5 VALUE 30101.
* Connection disabled
 77  SQL-RC-W30102	       PIC S9(9) COMP-5 VALUE 30102.

* Database Monitor SQLCODES

* bad path specified for event monitor
 77  SQLM-RC-BAD-PATH	       PIC S9(4) COMP-5 VALUE -1612.
* bad OPTION specified for event monitor
 77  SQLM-RC-BAD-OPTION        PIC S9(4) COMP-5 VALUE -1613.
* I/O error on activating event monitor
 77  SQLM-RC-IO-ERROR	       PIC S9(4) COMP-5 VALUE -1614.
* Event monitor not activated
 77  SQLM-RC-NOT-ACTIVATED     PIC S9(4) COMP-5 VALUE -1616.
* Event monitor data files are full
 77  SQLM-RC-EVMON-FULL        PIC S9(4) COMP-5 VALUE -1617.
* Event monitor path is in use
 77  SQLM-RC-PATH-IN-USE       PIC S9(4) COMP-5 VALUE -1618.
* Cannot drop active event monitor
 77  SQLM-RC-CANNOT-DROP       PIC S9(4) COMP-5 VALUE -1619.
* Must commit to use event monitor
 77  SQLM-RC-MUST-COMMIT       PIC S9(4) COMP-5 VALUE -1621.
* Invalid state
 77  SQLM-RC-BAD-STATE	       PIC S9(4) COMP-5 VALUE -1622.
