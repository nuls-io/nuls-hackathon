package utils

import (
    "net/http"
    "encoding/json"
    "fmt"
    "bytes"
    "io/ioutil"
    "unsafe"
)

type JsonPostSample struct {
}

func  SendEsms(account,password,mobile,smsmsg,smsurl string) {
    params := make(map[string]interface{})
	// API账号，50位以内。必填
    params["account"] = account
    // API账号对应密钥，联系客服获取。必填
    params["password"] = password
    // 手机号码，格式(区号+手机号码)，例如：8615800000000，其中86为中国的区号
    params["mobile"] = mobile
    //短信内容。长度不能超过536个字符。必填
    params["msg"] = smsmsg
	//用户收到短信之后显示的发件人，国内不支持自定义，国外支持，但是需要提前和运营商沟通注册，具体请与TIG对接人员确定。选填
    params["senderId"] = ""
    bytesData, err := json.Marshal(params)
    if err != nil {
        fmt.Println(err.Error() )
        return
    }
    reader := bytes.NewReader(bytesData)
    url := smsurl
    request, err := http.NewRequest("POST", url, reader)
    if err != nil {
        fmt.Println(err.Error())
        return
    }
    request.Header.Set("Content-Type", "application/json;charset=UTF-8")
    client := http.Client{}
    resp, err := client.Do(request)
    if err != nil {
        fmt.Println(err.Error())
        return
    }
    respBytes, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println(err.Error())
        return
	}
	
    str := (*string)(unsafe.Pointer(&respBytes))
    fmt.Println(*str)
}