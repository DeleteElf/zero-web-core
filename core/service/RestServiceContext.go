package service

import (
	"github.com/DeleteElf/zero-web-core/core/middleware"
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
)

type RestServiceContext struct {
	Config          RestConf
	AuthInterceptor rest.Middleware //注册中间件
	ServiceContext[RestConf]
}

func NewRestServiceContext(c RestConf) *RestServiceContext {
	redisClient := redis.MustNewRedis(c.Redis.RedisConf) //加入redis 2
	return &RestServiceContext{
		Config:          c,
		AuthInterceptor: middleware.NewAuthInterceptor(redisClient).Handle, //初始化中间件
		ServiceContext: ServiceContext[RestConf]{
			Services:    make(map[string]ServiceObject[RestConf]), //初始化服务容器
			RedisClient: redisClient,
		},
	}
}

func (s *RestServiceContext) InitPlugin(server *rest.Server, serviceObject ServiceObject[RestConf]) bool {
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
