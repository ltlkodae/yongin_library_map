library('ggmap')
library('stringr')

libTbl<-read.table("library_info_01.csv", sep=',', head=TRUE)
mapCenter<-c((max(libTbl$WGS84경도)+min(libTbl$WGS84경도))/2, (max(libTbl$WGS84위도)+min(libTbl$WGS84위도))/2)

yonginMap<-get_map(mapCenter, zoom = 12, maptype = 'roadmap')

libTbl$도서자료수<-as.numeric(str_replace_all(levels(libTbl$도서자료수), ',', ""))
libTbl$비도서자료수<-as.numeric(str_replace_all(levels(libTbl$비도서자료수), ',', ""))
#libTbl$연속간행물자료수<-as.numeric(str_replace_all(levels(libTbl$연속간행물자료수), ',', ""))

ggmap(yonginMap) + 
  geom_point(data=libTbl, aes(x=WGS84경도, y=WGS84위도), color= "red",
             size=(libTbl$도서자료수+libTbl$연속간행물자료수+libTbl$비도서자료수)/50000) +
  geom_text(data=libTbl, aes(x=WGS84경도, y=WGS84위도+0.005, label=도서관명), color= "black", size=2)

ggsave("yonginLibMap.png", dpi=512)
            
          
