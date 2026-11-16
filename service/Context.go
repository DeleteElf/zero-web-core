package service

import (
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
)

// Context 服务上下文接口
type Context[T Config] interface {
	InitPlugin(server *rest.Server, serviceObject ServiceObject[T]) bool
}

type ServiceContext[T Config] struct {
	Config      T
	Services    map[string]ServiceObject[T] //注册服务组件
	Middlewares map[string]rest.Middleware
	RedisClient *redis.Redis
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

func NewServiceContext[T Config](cfg T) *ServiceContext[T] {
	redisClient := redis.MustNewRedis(cfg.GetRedisConf().RedisConf) //加入redis 2
	return &ServiceContext[T]{
		Config:      cfg,
		Services:    make(map[string]ServiceObject[T]), //初始化服务容器
		Middlewares: make(map[string]rest.Middleware),  //初始化拦截器中间件
		RedisClient: redisClient,
	}
}

func (s *ServiceContext[T]) InitPlugin(server *rest.Server, serviceObject ServiceObject[T]) bool {
	result, hasKey := s.Config.GetPlugins()[serviceObject.Name]
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
