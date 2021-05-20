use pt;

-- ----------------------------
-- Procedure structure for NewHNV2
-- ----------------------------
DROP PROCEDURE IF EXISTS `NewHNV2`;
delimiter ;;
CREATE PROCEDURE `NewHNV2`(IN `cid` text,IN `title_name` text,IN `title_code` text,IN `fname` text,IN `lname` text,IN `sex_code` text,IN `date_birthdate` text,IN `marriage_code` text,IN `blood_code` text,IN `nation_code` text,IN `race_code` text,IN `address` text,IN `village` text,IN `tambon_code` text,IN `amphur_code` text,IN `province_code` text,IN `phone` text,IN `occupat_code` text,IN `mom_title` text,IN `mom_fname` text,IN `mom_lname` text,IN `dad_title` text,IN `dad_fname` text,IN `dad_lname` text,IN `cont_title` text,IN `cont_fname` text,IN `cont_lname` text,IN `cont_relation_code` text,IN `send_screen_roomcode` text,IN `card_register_roomcode` text,IN `register_user_name` text,IN `cont_address` text,IN `cont_village` text,IN `cont_tambon_code` text,IN `cont_amphur_code` text,IN `cont_province_code` text,IN `cont_phone` text,IN `passport` text,IN `title_en` text,IN `fname_en` text,IN `lname_en` text,IN `religion_code` text,OUT `new_hn` text)
BEGIN
	#Routine body goes here...
SET @regdate = DATE_FORMAT(NOW(),'%Y-%m-%d');
SET @cid = cid;
SET @NewCid = CONCAT(LEFT(@cid,1),'-',right(LEFT(@cid,5),4),'-',right(left(@cid,10),5),'-',left(right(@cid,3),2),'-',right(@cid,1));
#SELECT @NewCid;
SET @y = DATE_FORMAT(NOW(),'%Y');
SET @t = DATE_FORMAT(NOW(),'%H:%i:%s');
SET @hn_no = null;
SET @hn_length = NULL;
SET @new_hn = NULL;
SET @pcucode = NULL;

SELECT codehos into @pcucode FROM hosdata.confighos;
select get_lock('NEWHN',5)  hnlock;

select `no`,width into @hn_no,@hn_length from hosdata.docno where code='HN' and year=@y;
#SELECT @hn_no,@hn_length;
SELECT right(concat('0000000000',(IFNULL(@hn_no,0)+1)),@hn_length) into @new_hn;
#SELECT @new_hn;

update hosdata.docno set no =  (IFNULL(@hn_no,0)+1)  where code='HN' and year=@y limit 1;

#select cast(time_format(now(),'%H:%i:%s') as char) as timenow;
insert into pt.pt (regdate,hn,cardid,pttitle,ptfname,ptlname,ptsex,ptdob,ptdobtrust,married,ptblgr,ptnation,ptrace,religion,ptaddress,ptvillage,pttambon,ptamphur,ptprovince,ptphone,ptoccupat,mottitle,motfname,motlname,fattitle,fatfname,fatlname,contacttitle,contactfname,contactlname,relation,lastvisitdate,sendscrroom,cardroom,carduser,timereg,typehn,contaddress,contvillage,conttambon,contamphur,contprovince,updatedate,user_update,pcucode,passport,date_update,pttitle_en,ptfname_en,ptlname_en) values (@regdate,@new_hn,@NewCid,title_name,fname,lname,sex_code,date_birthdate,'AGETY1',marriage_code,blood_code,nation_code,race_code,religion_code,address,village,tambon_code,amphur_code,province_code,phone,occupat_code,mom_title,mom_fname,mom_lname,dad_title,dad_fname,dad_lname,cont_title,cont_fname,cont_lname,cont_relation_code,'00:00:00',send_screen_roomcode,card_register_roomcode,register_user_name,@t,'HNTY1',cont_address,cont_village,cont_tambon_code,cont_amphur_code,cont_province_code,@regdate,register_user_name,@pcucode,'',@regdate,title_en,fname_en,lname_en);
select release_lock('NEWHN');
insert ignore into pcu.person(p_code,villcode,h_code,family_no,id_card,fname,lname,prename,typearea,birthdate,hn,d_update,occu,sex,mari_stat,nation,pcucode,edu,relig) values(@new_hn,'','','1',@cid,fname,lname,title_code,'4',date_birthdate,@new_hn,@regdate,occupat_code,right(sex_code,1),'1',nation_code,@pcucode,'9','01');
update pcu.person set id_card=@cid,pcucode=@pcucode  where p_code=@new_hn;
#update pcu.person set  occu='404',sex='1',mari_stat='1',nation='99',origin='99',relig='01'    where p_code=@new_hn;
update pt.pt set contphone=cont_phone where hn=@new_hn;
update pcu.person set prename=title_code,fname=fname,lname=lname,birthdate=date_birthdate ,sex=RIGHT(sex_code,1),occu=occupat_code,origin=race_code,nation=nation_code ,father=dad_fname,mother=mom_fname,mari_stat='1',h_code='' ,id_card=@cid,villcode='',typearea=4,h_no='',sendamp=null,pcucode=@pcucode,relig='01',passport=passport,blood_group=blood_code  where p_code=@new_hn;
set new_hn = @new_hn;
END
;;
delimiter ;


ALTER TABLE `pt`.`pt` 
ADD COLUMN `pttitle_en` varchar(5) NULL AFTER `ptlname`,
ADD COLUMN `ptfname_en` varchar(30) NULL AFTER `pttitle_en`,
ADD COLUMN `ptlname_en` varchar(30) NULL AFTER `ptfname_en`;
