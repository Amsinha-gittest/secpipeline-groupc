package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, Dockerized Go!")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Group C Starting server on :80")
	http.ListenAndServe(":80", nil)
}
