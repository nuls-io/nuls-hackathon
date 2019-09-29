package utils

import (
	"errors"
	"fmt"
	"time"
	"log"
	jwt "github.com/dgrijalva/jwt-go"
)

type JwtClaims struct {
	*jwt.StandardClaims
	UserId      string
	DomainId    string
	OrgUnitId   string
	Authorities string `json:"authorities"`
}

var (
	key []byte = []byte("morvooapi@163.com-jwt")
)
//生成token令牌
func GenToken(user_id, domain_id, org_id string, dt int64) string {
	fmt.Println(time.Now().Unix())
	claims := JwtClaims{
		&jwt.StandardClaims{
			ExpiresAt: time.Now().Unix() + dt,
			Issuer:    "morvooapi",
		},
		user_id,
		domain_id,
		org_id,
		"ROLE_ADMIN,AUTH_WRITE,ACTUATOR",
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	ss, err := token.SignedString(key)
	if err != nil {
		// logs.Error(err)
		log.Printf("parse date err： %v", err)
		return ""
	}
	return ss
}

//销毁token
func DestoryToken() string {

	claims := JwtClaims{
		&jwt.StandardClaims{
			ExpiresAt: int64(time.Now().Unix() - 99999),
			Issuer:    "morvooapi",
		},
		"exit",
		"exit",
		"exit",
		"ROLE_ADMIN,AUTH_WRITE,ACTUATOR",
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	ss, err := token.SignedString(key)
	if err != nil {
		// log.Error(err)
		log.Printf("parse date err： %v", err)
		return ""
	}
	return ss
}
//检查token
func CheckToken(token string) bool {
	_, err := jwt.Parse(token, func(*jwt.Token) (interface{}, error) {
		return key, nil
	})
	if err != nil {
		fmt.Println("parase with claims failed.", err)
		return false
	}
	return true
}
//解析jwt
func ParseJwt(token string) (*JwtClaims, error) {
	var jclaim = &JwtClaims{}
	_, err := jwt.ParseWithClaims(token, jclaim, func(*jwt.Token) (interface{}, error) {
		return key, nil
	})
	if err != nil {
		fmt.Println("parase with claims failed.", err, token)
		return nil, errors.New("parase with claims failed.")
	}
	return jclaim, nil
}
