package service

import (
	"github.com/deleteelf/zero-core/ado"
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
	"github.com/zeromicro/go-zero/zrpc"
)

type Config interface {
}

type ServiceConf struct {
	// Service 服务类型 Rest 1 EtcdClient 2 EtcdServer 4,如果没有配置，默认是Website 1
	Service ServiceType     `json:",default=1"`
	Plugins map[string]bool `json:"Plugins"`
}

type SessionConf struct {
	SessionTime      int   `json:",default=1800"`
	TokenReplaceTime int64 `json:",default=86400"`
	Config
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
	EtcdServer //ServiceType = "server"
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
	Redis    redis.RedisKeyConf
	SessionConf
	Config
}

type RpcServerConf struct {
	ServiceConf
	zrpc.RpcServerConf
	DbConfig ado.DbConfig
	Redis    redis.RedisKeyConf
	Config   //理论上rpc服务端，并不会去验证session 和token
}
type RpcClientConf struct {
	ServiceConf
	rest.RestConf
	zrpc.RpcClientConf
	Redis redis.RedisKeyConf //客户端是否需要，还待定
	SessionConf
	Config
}
