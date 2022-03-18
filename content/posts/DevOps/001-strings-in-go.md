---
title: "Tips: Using String better way in Go"
date: '2022-03-18'
categories: ["GoLang"]
highlight: false
tags: ["programming", "go", "strings", "golang"]
---

### Background 🧐
Go includes strings as a builtin type. The zero value for a string is the empty string.
Go supports Unicode; Strings in Go are immutable; you can reassign the value of a string variable, but you cannot change the value of the string that is assigned to it.
As i have observed most of its characteristics are inherited from C.

### Multiline strings in Go

If you are like me, you will want to know how to create multi-line strings pretty quickly for one reason or another 😁

```go
str := `This is a
multiline
string introduction for go strings.`
```

### Concatenate Strings in Go

While you can concatenate strings with the + operator, and this works file

```go
str := "vivek"
str = str + "sheshadri"
```

it is more efficient to use something like a bytes.Buffer or a strings.Builder rather than the above use case and this is more efficient if you are combining Lots of strings

```go
var sb strings.Builder
sb.WriteString("vivek")
sb.WriteString("sheshadri")
```
##### complete code
```go
package main
import (
	"fmt"
	"strings"
)
func main() {
	var sb strings.Builder
	sb.WriteString("vivek")
	sb.WriteString("sheshadri")
	fmt.Println(sb.String())
}
```
Outputs: "viveksheshadri" .

### Strings Conversion in Go

In Go, You can't simply cast a number to a string and it does NOT work as you may expect

```go
package main
import "fmt"
func main() {
	number := 728
	str := string(number)
	fmt.Println(str)
}
```
```go
Outputs: {
Program exited.
```
Most notably from above exmaple, simply writing string(728) won't work as you expected and the result will NOT be "728"

#### Solution:
To convert a number to string, Go has defined function strconv.Itoa or fmt.sprintf as below.
1. Using function strconv.Itoa
```go
number := 728
strConv := strconv.Itoa(number)
fmt.Println(strConv)
```
```go
Outputs: 728
```
2. Using function fmt.sprintf
```go
number := 234
strB := fmt.Sprintf("%d", number)
fmt.Println(strB)
```
```go
Outputs: 234
```
### Strings to byte slices in Go

In many languages functions will only accepts a string or a byte slice, and converting them back and forth can be tricky.
but in Go strings can be converted into byte slices, and byte slices can be converted into strings, will see how with an example below.

1. Converting string to a byte slice
```go
package main
import "fmt"
var byt []byte
func main() {
	str := "a string"
	byt = []byte(str)
	fmt.Println(byt)
}
```
```go
Outputs: [97 32 115 116 114 105 110 103]
```
2. To converting back the above byte slice value to a string

```go
var str string
str = string(byt)
```

Hope these tips help you out in writing more efficient Go, I will post more topics tricks and tips on Go in my next article.