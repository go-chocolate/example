package module

import (
	"github.com/go-chocolate/example/internal/app/dependency"
	"github.com/go-chocolate/example/internal/module/auth"
)

func Setup() error {
	services.Auth = auth.NewService(dependency.Get().KVStorage)

	return nil
}

var services = &struct {
	Auth auth.Service
}{}

func GetAuthService() auth.Service {
	return services.Auth
}
