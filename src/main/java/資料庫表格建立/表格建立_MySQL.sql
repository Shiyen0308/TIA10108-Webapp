CREATE DATABASE IF NOT EXISTS test;

use test;

DROP TABLE IF EXISTS ART;



-- 以下設定: 自增主鍵的起點值，也就是初始值，取值範圍是1 .. 655355 --
set auto_increment_offset=1;
-- 以下設定: 自增主鍵每次遞增的量，其預設值是1，取值範圍是1 .. 65535 --
set auto_increment_increment=1; 
CREATE TABLE ART (
	ART_ID	INT AUTO_INCREMENT NOT NULL,
	ART_TITLE VARCHAR(255),
	ART_CONTENT MEDIUMTEXT,
	ART_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
	ART_REPLY INT,
	ART_FAVOR INT,
	ART_VIEW INT,
	CONSTRAINT ART_PRIMARY_KEY PRIMARY KEY (ART_ID)
) AUTO_INCREMENT = 1;

INSERT INTO ART (ART_TITLE,ART_CONTENT,ART_TIMESTAMP,ART_REPLY,ART_FAVOR,ART_VIEW)  VALUES ("生命的超越者 - 杰倫達爾默","大家好，我是來自","2022-05-13 11:15:55",NULL,1,1);
INSERT INTO ART (ART_TITLE,ART_CONTENT,ART_TIMESTAMP,ART_REPLY,ART_FAVOR,ART_VIEW)  VALUES ("【提醒】5/1開始的手環活動獎勵要記得每天領 - 杰倫達爾默","雖然介面起來就跟普通的每日簽到差不多
但這次的活動說明有特別提到","2022-05-13 11:15:55",2,1,1);
INSERT INTO ART (ART_TITLE,ART_CONTENT,ART_TIMESTAMP,ART_REPLY,ART_FAVOR,ART_VIEW)  VALUES ("【情報】【美好祝福福袋】維護完畢公告","親愛的冒險者們：

【美好祝福福袋】系統異常問題已排除，
活動網頁已於12:00重新開放。

於4/24(三)14:00-15:30維護前，
若有遇到任何活動上問題
請於5/7(二)23:59前透過客服聯繫進行處理，
感謝冒險者們持續的支持，此段時間若有造成不便，敬請見諒~","2022-05-12 12:16:55",1,1,1);

