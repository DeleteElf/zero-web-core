package ctx

import (
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
)

// Context 服务上下文接口
type Context[T Config] interface {
	//InitPlugin(server *rest.Server, serviceObject ServiceObject) bool
	GetService(key string) (ServiceObject, bool)
}

type ServiceContext[T Config] struct {
	Config      T
	Services    map[string]ServiceObject //注册服务组件
	Middlewares map[string]rest.Middleware
	RedisClient *redis.Redis
	Context[T]
}

// ServiceObject 基础服务对象，需要实现服务接口
type ServiceObject struct {
	Name               string
	Version            string
	Enabled            bool
	SupportServiceType ServiceType
	Service            any
}

func NewServiceContext[T Config](cfg T) *ServiceContext[T] {
	redisClient := redis.MustNewRedis(cfg.GetRedisConf().RedisConf) //加入redis
	return &ServiceContext[T]{
		Config:      cfg,
		Services:    make(map[string]ServiceObject),   //初始化服务容器
		Middlewares: make(map[string]rest.Middleware), //初始化拦截器中间件
		RedisClient: redisClient,
	}
}

func (s ServiceContext[T]) GetService(key string) (*ServiceObject, bool) {
	result, ok := s.Services[key]
	if !ok {
		return nil, ok
	}
	return &result, ok
}

// RestServiceContext Rest服务上下文，泛型的确定形态
type RestServiceContext ServiceContext[RestConf]

// RpcClientServiceContext Rpc客户端服务上下文，泛型的确定形态
type RpcClientServiceContext ServiceContext[RpcClientConf]

// RpcServerServiceContext Rpc服务端服务上下文，泛型的确定形态
type RpcServerServiceContext ServiceContext[RpcServerConf]
