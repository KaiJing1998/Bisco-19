con <- dbConnect(MySQL(),
                  user = 'techvest_covidAdmin',
                  password = 'gRBOp;$[F[!g',
                  dbname = 'techvest_covid',
                  host = '143.198.217.144'
)

onStop(function(){
  dbDisconnect(con)
})

get_data <- function(con) {
  MBA_Online <- dbGetQuery(con, "SELECT * FROM DAILYCASES")
  #return(MBA_Online)
}

MBA_Online <- get_data(con=con)

ord <- function(MBA_Online) {
  print(data)
}



