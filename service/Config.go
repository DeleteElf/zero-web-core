package service

import (
	"github.com/deleteelf/zero-core/ado"
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
	"github.com/zeromicro/go-zero/zrpc"
)

type Config interface {
	GetPlugins() map[string]bool // 所有 T 都必须提供
	GetRedisConf() *redis.RedisKeyConf
	GetDbConfig() *ado.DbConfig
}

type ServiceConf struct {
	// Service 服务类型 Rest 1 EtcdClient 2 EtcdServer 4,如果没有配置，默认是Website 1
	Service ServiceType     `json:",default=1"`
	Plugins map[string]bool `json:"Plugins"`
	Redis   redis.RedisKeyConf
	SessionConf
	Config `json:"-"`
}

func (sc ServiceConf) GetPlugins() map[string]bool {
	return sc.Plugins
}
func (sc ServiceConf) GetRedisConf() *redis.RedisKeyConf {
	return &sc.Redis
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
	// EtcdClient 用于支持etcd集群的客户端
	EtcdClient //ServiceType = "client"
	// EtcdServer 用于支持etcd集群的服务端
	EtcdServer //ServiceType = "service"
)

func (e ServiceType) IsValid() bool {
	switch e {
	case Rest, EtcdClient, EtcdServer:
		return true
	}
	return false
}

type RestConf struct {
	ServiceConf
	rest.RestConf
	DbConfig ado.DbConfig
}

func (rc RestConf) GetDbConfig() *ado.DbConfig {
	return &rc.DbConfig
}

type RpcServerConf struct {
	ServiceConf
	zrpc.RpcServerConf
	DbConfig ado.DbConfig
}

func (rsc RpcServerConf) GetDbConfig() *ado.DbConfig {
	return &rsc.DbConfig
}

type RpcClientConf struct {
	ServiceConf
	rest.RestConf
	zrpc.RpcClientConf
}

func (rcc RpcClientConf) GetDbConfig() *ado.DbConfig {
	return nil
}
