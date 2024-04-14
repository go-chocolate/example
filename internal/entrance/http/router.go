package http

import (
	"github.com/gin-gonic/gin"
	"github.com/go-chocolate/example/internal/entrance/http/handler"
	"github.com/go-chocolate/example/internal/entrance/http/middleware"
	"github.com/go-chocolate/example/version"
	"net/http"
)

func Router() http.Handler {
	router := gin.New()
	router.GET("/version", func(ctx *gin.Context) {
		version.HTTPHandler()(ctx.Writer, ctx.Request)
	})
	router.POST("/login", handler.Login)
	router.POST("/register", handler.Register)
	router.POST("/hello", middleware.Authorize, handler.Hello)
	return router
}
