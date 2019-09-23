/*
有关Http协议GET和POST请求的封装
*/
package utils

import (
    "net/http"
    "io"
    "bytes"
    "encoding/json"
    "io/ioutil"
    "time"
    "crypto/tls"
)

//发送GET请求
//url:请求地址
//response:请求返回的内容
func CurlGet(url string) (response string) {
    client := http.Client{Timeout: 5 * time.Second}
    resp, error := client.Get(url)
    if resp == nil{
        return  ""
    }
    defer resp.Body.Close()
    if error != nil {
        panic(error)
    }

    var buffer [512]byte
    result := bytes.NewBuffer(nil)
    for {
        n, err := resp.Body.Read(buffer[0:])
        result.Write(buffer[0:n])
        if err != nil && err == io.EOF {
            break
        } else if err != nil {
            panic(err)
        }
    }

    response = result.String()
    return
}

//发送POST请求
//url:请求地址，data:POST请求提交的数据,contentType:请求体格式，如：application/json
//content:请求放回的内容
func CurlPost(url string, data interface{}, contentType string) (content string) {
    jsonStr, _ := json.Marshal(data)
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonStr))
    req.Header.Add("content-type", contentType)
    if err != nil {
        panic(err)
    }
    defer req.Body.Close()
    client := &http.Client{Timeout: 5 * time.Second}
    resp, error := client.Do(req)
    if resp == nil{
        return  ""
    }
    if error != nil {
        panic(error)
    }
    defer resp.Body.Close()
    result, _ := ioutil.ReadAll(resp.Body)
    content = string(result)
    return
}
//发送POST请求(https)亲测可用
func CurlPosts(url string, data interface{}, contentType,token string) (content string) {
    jsonStr, _ := json.Marshal(data)
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonStr))
    req.Header.Add("content-type",contentType)
    //token值(适合本链)若是其他的https,可以不需要这样的参数
    req.Header.Add("Authorization",token)
    if err != nil {
        panic(err)
    }
    defer req.Body.Close()
    //跳过证书验证
    tr := &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    }
    client := &http.Client{Transport: tr}
    resp, error := client.Do(req)
    if resp == nil{
        return  ""
    }
    if error != nil {
        panic(error)
    }
    defer resp.Body.Close()
    result, _ := ioutil.ReadAll(resp.Body)
    content = string(result)
    return
}
//发送GET请求(https),亲测可用
func CurlGets(url string, data interface{}, contentType,token string) (content string) {
    jsonStr, _ := json.Marshal(data)
    req, err := http.NewRequest("GET", url, bytes.NewBuffer(jsonStr))
    req.Header.Add("content-type",contentType)
    //token值(适合本链)若是其他的https,可以不需要这样的参数
    req.Header.Add("Authorization",token)
    if err != nil {
        panic(err)
    }
    defer req.Body.Close()
    //跳过证书验证
    tr := &http.Transport{
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    }
    client := &http.Client{Transport: tr}
    resp, error := client.Do(req)
    if resp == nil{
        return  ""
    }
    if error != nil {
        panic(error)
    }
    defer resp.Body.Close()
    result, _ := ioutil.ReadAll(resp.Body)
    content = string(result)
    return
}