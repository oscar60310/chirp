#CreateEvent
methos **POST**<br>
##SEND:
```HTTP
POST /CreateEvent HTTP:/1.1
{
    "token": "dsdvwevwqownieg94apovn93nv98n29pnv9",
	"data":
	{
		"title": "宜蘭監獄三年遊",
		"location": "宜蘭監獄",
		"position" :
		{
			"lat" : "23.1212113",
			"lng" : "122.213213"
		},
		"Time":
		{
			"From" : 2016/06/04 20:20,
			"To" : 2019/06/04 20:20
		},
		"people_num" : "100",
		"timeline" : 
		[
			{
				"datetime" : 2016/06/04 20:20,
				"event" : "監獄門口集合一起進去"
			},
			{
				"datetime" : 2019/06/04 20:20,
				"event" : "監獄門口集合一起出來"
			}
		],
		"brid_limite" : "1",
		"note" : "不需要帶任何東西"
	}
}


```
##RESPOND
```HTTP
POST /CreateEvent HTTP:/1.1
{
    "Statu": "200",
    "Eventid": "JKD5EDQ9543"
}
```
