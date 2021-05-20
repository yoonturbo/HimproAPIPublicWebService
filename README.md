# HimproAPI
WebService API ASP.net Core 3.1 Public for MySQL Databases support Himpro his
Support MySQl 5.6 or Higher

## รันคำสั่งสร้างฟังชั่นใน mysql จากไฟล์ "himpro_api_db.sql"
### หมายเหตุ มีคำสั่งเพิ่มฟิวชื่อภาษาอังกฤษ 3 ฟิว ในตาราง pt.pt แนะนำให้ดำเนินการตอนกลางคืนที่มีผู้ใช้งานน้อยๆ จะไม่กระทบกับผู้ใช้ himpro
```sql
ALTER TABLE `pt`.`pt` 
ADD COLUMN `pttitle_en` varchar(5) NULL AFTER `ptlname`,
ADD COLUMN `ptfname_en` varchar(30) NULL AFTER `pttitle_en`,
ADD COLUMN `ptlname_en` varchar(30) NULL AFTER `ptfname_en`;
```
Config in DbConfig.txt

## Example
```json
{
	"ip":"localhost",
	"username":"root",
	"password":"123456",
	"port":"3306",
	"dbname":"hosdata"
}
```



Edit MyTokey in token.txt
## token.txt
```baht
abcdeft
```
Config Smart Health ID Account in "smart_health_id.json"
## smart_health_id.json
```json
{
	"username":"abc",
	"password":"xxx"
}
```
