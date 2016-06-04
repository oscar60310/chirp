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
		"time":
		{
			"From" : "2016/06/04 20:20",
			"To" : "2019/06/04 20:20"
		},
		"people_num" : "100",
		"timeline" : 
		[
			{
				"datetime" : "2016/06/04 20:20",
				"event" : "監獄門口集合一起進去"
			},
			{
				"datetime" : "2019/06/04 20:20",
				"event" : "監獄門口集合一起出來"
			}
		],
		"bird_limite" : "1",
		"note" : "不需要帶任何東西"
	}
}


```
參數 | 說明 | 類別 | 必要
------------ | ------------- | ------------- | ------------- 
token | 使用者金鑰 | String | Yes
data | 資料內容 | {"title","location","position","time","people_num","timeline","bird_limite","note"} | Yes
title | 活動名稱 | String | Yes
location | 活動地點 | String | Yes
position | 活動地點座標 | {"lat","lng"} | No
-lat | 活動地點緯度 | Double | No
-lng | 活動地點經度 | Double | No
time | 活動時間 | {"From","To"} | Yes
-From | 活動開始時間 | DateTime | Yes
-To | 活動結束時間 | DateTime | No
people_num | 預計人數 | Int | Yes
timeline | 行程表 | [{"datetime","event"}] | Yes
-datetime | 時間 | DateTime | Yes
-event | 行程 | String | Yes
bird_limite | 鴿子數量限制 | Int | Yes
note | 備註 | String | No




##RESPOND
```HTTP
POST /CreateEvent HTTP:/1.1
{
    "Statu": "200",
    "Eventid": "JKD5EDQ9543"
}
```
參數 | 說明 | 類別 | 必要
------------ | ------------- | ------------- | ------------- 
Statu | 狀態(200成功,401參數不符,402金鑰驗證失敗,500伺服器錯誤) | String | Yes
Description | 說明 | String | No
Eventid | 行程ID(如果新增成功的話) | String | Yes
