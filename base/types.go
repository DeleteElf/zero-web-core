package base

type IdRequest struct {
	Id string `path:"id"` //设置请求的格式要求
}

type Response struct {
	Code    string `json:"code"`
	Message string `json:"message"` //设置应答的格式
	Result  any    `json:"result"`
}
