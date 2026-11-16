package service

import (
	"net/http"

	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
)

// Context 服务上下文接口
type Context[T Config] interface {
	InitPlugin(server *rest.Server, serviceObject ServiceObject[T]) bool
}

type Interceptor interface {
	Handle(next http.HandlerFunc) http.HandlerFunc
}

type ServiceContext[T Config] struct {
	Services     map[string]ServiceObject[T] //注册服务组件
	Interceptors map[string]Interceptor
	RedisClient  *redis.Redis
	Context[T]
}

// Service 基础服务接口
type Service[T Config] interface {
	// RegisterHandlers 注册服务，需要处理具体的领域业务和中间件加载逻辑
	RegisterHandlers(server *rest.Server, serverCtx Context[T])
}

// ServiceObject 基础服务对象，需要实现服务接口
type ServiceObject[T Config] struct {
	Name               string
	Version            string
	Enabled            bool
	SupportServiceType ServiceType
	Service[T]
}
