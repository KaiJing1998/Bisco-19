library(RMySQL)

mydb <- dbConnect(MySQL(),
                  user = 'techvest_covidAdmin',
                  password = 'gRBOp;$[F[!g',
                  dbname = 'techvest_covid',
                  host = '143.198.217.144'
)

dbListTables(mydb)
dbListFields(mydb,'DAILYCASES')

rs = dbSendQuery(mydb, "SELECT * FROM DAILYCASES")
datatable = fetch (rs, n= -1)
View(datatable)


