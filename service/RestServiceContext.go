package service

//
//import (
//	"github.com/zeromicro/go-zero/core/stores/redis"
//	"github.com/zeromicro/go-zero/rest"
//)
//
//type RestServiceContext struct {
//	ServiceContext[RestConf]
//}
//
//func NewRestServiceContext(c RestConf) *RestServiceContext {
//	redisClient := redis.MustNewRedis(c.Redis.RedisConf) //加入redis 2
//	return &ServiceContext[RestConf]{
//		Config:      c,
//		Services:    make(map[string]ServiceObject[RestConf]), //初始化服务容器
//		Middlewares: make(map[string]rest.Middleware),         //初始化拦截器中间件
//		RedisClient: redisClient,
//	}
//}
//
////
////func (s *RestServiceContext) InitPlugin(server *rest.Server, serviceObject ServiceObject[RestConf]) bool {
////	result, hasKey := s.Config.Plugins[serviceObject.Name]
////	if !hasKey {
////		return false
////	}
////	serviceObject.Enabled = result
////	if !result {
////		return false
////	}
////	serviceObject.RegisterHandlers(server, s)
////	return true
////}
