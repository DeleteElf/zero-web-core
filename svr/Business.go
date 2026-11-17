package svr

import (
	"github.com/deleteelf/zero-core/ado"
)

// Business 业务层基类
type Business interface {
	GetConnection()
}

type BaseBusiness struct {
	DbConfig *ado.DbConfig
	Business
}

func (b BaseBusiness) GetConnection() (ado.DbInterface, error) {
	return ado.CreateDbByConfig(b.DbConfig)
}
