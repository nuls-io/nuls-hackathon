package utils

import (
	"bytes"
	"errors"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
)
func HttpPostJson(url string, params []byte) ([]byte, error) {
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(params))
	if err != nil {
		log.Println("http new request failed")
		return nil, err
	}
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	res, err := client.Do(req)
	defer res.Body.Close()
	return ioutil.ReadAll(res.Body)
}

func HttpGetJson(url string, params []byte) ([]byte, error) {
	req, err := http.NewRequest("GET", url, bytes.NewBuffer(params))
	if err != nil {
		return nil, err
	}
	req.Header.Set("Content-Type", "application/json")
	client := &http.Client{}
	res, err := client.Do(req)
	defer res.Body.Close()
	return ioutil.ReadAll(res.Body)
}

func HttpReq(get_or_post string, ReqUrl string, ReqMsg io.Reader) ([]byte, error) {
	var err error

	client := &http.Client{}
	req, _ := http.NewRequest(get_or_post, ReqUrl, ReqMsg)
	//req.Header.Set("Connection", "keep-alive")
	resp, err := client.Do(req)

	if err != nil || resp == nil {
		fmt.Println("Error: get_or_post:", get_or_post, ", resp:", resp, ",err: ", err)
		return nil, errors.New("Error: send http failed")
	}

	if resp.StatusCode != 200 {
		fmt.Println("Error: get_or_post:", get_or_post, ", ReqUrl:", ReqUrl, ",resp: ", resp)
		return nil, errors.New("Error: resp.StatusCode is not 200")
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	if resp.StatusCode != 200 {
		return nil, errors.New(string(body))
	}

	return body, nil
}
