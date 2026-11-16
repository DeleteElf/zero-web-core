package service

import (
	"github.com/DeleteElf/zero-web-core/core/middleware"
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
)

type RpcClientServiceContext struct {
	Config          RpcClientConf
	AuthInterceptor rest.Middleware //注册中间件
	ServiceContext[RpcClientConf]
}

func NewRpcClientServiceContextt(c RpcClientConf) *RpcClientServiceContext {
	redisClient := redis.MustNewRedis(c.Redis.RedisConf) //加入redis 2
	return &RpcClientServiceContext{
		Config:          c,
		AuthInterceptor: middleware.NewAuthInterceptor(redisClient).Handle, //初始化中间件
		ServiceContext: ServiceContext[RpcClientConf]{
			Services:    make(map[string]ServiceObject[RpcClientConf]), //初始化服务容器
			RedisClient: redisClient,
		},
	}
}

func (s *RpcClientServiceContext) InitPlugin(server *rest.Server, serviceObject ServiceObject[RpcClientConf]) bool {
	result, hasKey := s.Config.Plugins[serviceObject.Name]
	if !hasKey {
		return false
	}
	serviceObject.Enabled = result
	if !result {
		return false
	}
	serviceObject.RegisterHandlers(server, s)
	return true
}
