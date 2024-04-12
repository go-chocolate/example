package http

import (
	"net/http"

	"github.com/julienschmidt/httprouter"

	"github.com/go-chocolate/example/version"
)

func Router() http.Handler {
	router := httprouter.New()

	router.GET("/version", func(writer http.ResponseWriter, request *http.Request, params httprouter.Params) {
		version.HTTPHandler()(writer, request)
	})

	return router
}
