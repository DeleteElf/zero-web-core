package svr

import (
	"github.com/DeleteElf/zero-core/ado"
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
