package service

import (
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
)

type RpcServerServiceContext struct {
	Config RpcServerConf
	ServiceContext[RpcServerConf]
}

func NewRpcServerServiceContext(c RpcServerConf) *RpcServerServiceContext {
	redisClient := redis.MustNewRedis(c.Redis.RedisConf) //加入redis 2
	return &RpcServerServiceContext{
		Config: c,
		ServiceContext: ServiceContext[RpcServerConf]{
			Services:    make(map[string]ServiceObject[RpcServerConf]), //初始化服务容器
			RedisClient: redisClient,
		},
	}
}

func (s *RpcServerServiceContext) InitPlugin(server *rest.Server, serviceObject ServiceObject[RpcServerConf]) bool {
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
