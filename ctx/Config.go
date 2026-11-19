package ctx

import (
	"github.com/DeleteElf/zero-core/ado"
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
	"github.com/zeromicro/go-zero/zrpc"
)

type Config interface {
	GetPlugins() map[string]bool // 所有 T 都必须提供
	GetRedisConf() *redis.RedisKeyConf
	GetDbConfig() *ado.DbConfig
	GetServiceType() ServiceType
	GetTokenReplaceTime() int64
	GetSessionTime() int
}

type ServiceConf struct {
	// ServiceType 服务类型 Rest 1 RpcClient 2 RpcServer 4,如果没有配置，默认是Website 1
	ServiceType ServiceType     `json:",default=1"`
	Plugins     map[string]bool `json:"Plugins"`
	SessionConf
	Config `json:"-"`
}

func (sc ServiceConf) GetPlugins() map[string]bool {
	return sc.Plugins
}

func (sc ServiceConf) GetServiceType() ServiceType {
	return sc.ServiceType
}

func (sc ServiceConf) GetTokenReplaceTime() int64 {
	return sc.TokenReplaceTime
}
func (sc ServiceConf) GetSessionTime() int {
	return sc.SessionTime
}

type SessionConf struct {
	SessionTime      int   `json:",default=1800"`
	TokenReplaceTime int64 `json:",default=86400"`
}

type Domain struct {
	Name string
}
type FecLevel int

type ServiceType int

const (
	// Rest 独立网站
	Rest ServiceType = 1 << iota // "website"
	// RpcClient 用于支持etcd集群的客户端
	RpcClient //ServiceType = "client"
	// RpcServer 用于支持etcd集群的服务端
	RpcServer //ServiceType = "server"
)

func (e ServiceType) IsValid() bool {
	switch e {
	case Rest, RpcClient, RpcServer:
		return true
	}
	return false
}

type RestConf struct {
	ServiceConf
	rest.RestConf
	Redis    redis.RedisKeyConf `json:",optional"`
	DbConfig *ado.DbConfig
}

func (rc RestConf) GetDbConfig() *ado.DbConfig {
	return rc.DbConfig
}
func (rc RestConf) GetRedisConf() *redis.RedisKeyConf {
	return &rc.Redis
}

type RpcServerConf struct {
	ServiceConf
	zrpc.RpcServerConf
	DbConfig *ado.DbConfig
}

func (rsc RpcServerConf) GetDbConfig() *ado.DbConfig {
	return rsc.DbConfig
}
func (rsc RpcServerConf) GetRedisConf() *redis.RedisKeyConf {
	return &rsc.Redis
}

type RpcClientConf struct {
	ServiceConf
	rest.RestConf
	Redis           redis.RedisKeyConf `json:",optional"`
	RpcClientConfig zrpc.RpcClientConf //客户端配置里 也有middlewares 会冲突，我们需要放到下一级
}

func (rcc RpcClientConf) GetDbConfig() *ado.DbConfig {
	return nil
}
func (rcc RpcClientConf) GetRedisConf() *redis.RedisKeyConf {
	return &rcc.Redis
}
