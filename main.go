package main

import (
	"database/sql"
	"log"

	_ "github.com/alexbrainman/odbc"
	_ "github.com/go-sql-driver/mysql"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.GET("/test-connect-sql", func(c *gin.Context) {
		db, err := sql.Open("mysql", "myuser:mypassword@tcp(mysql:3306)/mydatabase")
		if err != nil {
			panic(err.Error())
		}
		defer db.Close()

		// Attempt to ping the database to verify the connection
		err = db.Ping()
		if err != nil {
			panic(err.Error())
		}
		c.JSON(200, gin.H{
			"message": "connect success",
		})
	})

	r.GET("/test-connect-odbc", func(c *gin.Context) {
		db, err := sql.Open("odbc",
			"DSN=myodbc8w")
		if err != nil {
			log.Fatal(err)
		}
		defer db.Close()
		err = db.Ping()
		if err != nil {
			panic(err.Error())
		}
		c.JSON(200, gin.H{
			"message": "connect success",
		})

	})

	r.Run(":3000") // listen and serve on 0.0.0.0:8080
}
