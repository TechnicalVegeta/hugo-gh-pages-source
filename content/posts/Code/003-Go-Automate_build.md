---
title: "Go to Automate and Integrate tools with Build"
date: '2022-06-14'
categories: ["GoLang"]
highlight: false
tags: ["programming", "go", "linting", "Venting", "golang", "gotools"]
highlightjslanguages: ["go"]
---

### 1️⃣ Background  

Modern software development relies on repeatable, automatable builds that can be run by anyone, anywhere, at any time.
This avoids the age-old developer excuse of “It works on my machine!” The way to do this is to use some kind of script to specify your build steps. 
Go has adopted *make* as their solution.

### 2️⃣ Make - Simple Autoamte Build

Sample project hello.go file contains below.

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, Vivek!")
}
```

Here’s a sample Makefile to add to our project:  

```make
.DEFAULT_GOAL := build

fmt:
		go fmt ./...
.PHONY:fmt 

lint: fmt
		golangci-lint run
.PHONY:lint

build: lint
		go build hello.go 
.PHONY:build
```
**Run Makefile** - Once the Makefile is in the Go Project Directory, type:  

**make**  

This will give the Output:

```output
go fmt ./...
hello.go
golangci-lint run
go build hello.go
```

**Explanation of Make file configuration:**  
it’s not too difficult to figure out what is going on. Each possible operation is called a target. The .DEFAULT_GOAL defines which
target is run when no target is specified. In our case, we are going to run the build target. Next we have the target definitions. The word before the colon (:) is the name
of the target. Any words after the target (like *lint* in the line *build: lint*) are the other targets that must be run before the specified target runs. The tasks that are
performed by the target are on the indented lines after the target.  

*PHONY* - By default, Makefile targets are "file targets" - they are used to build files from other files. Make assumes its target is a file, and this makes writing Makefiles relatively easy
However, sometimes you want your Makefile to run commands that do not represent physical files in the file system. examples for this are the common targets *"clean"* and *"all"*. Chances are this isn't the case, but you may potentially have a file named clean in your main directory. In such a case Make will be confused because by default the clean target would be associated with this file and Make will only run it when the file doesn't appear to be up-to-date with regards to its dependencies.

These special targets are called *PHONY* and you can explicitly tell Make they're not associated with files, as below example.

```go
clean: 
		rm -rf *.txt 
.PHONY:clean
```
Now if you run the command *make clean* it will run as expected even if you do have a file name called *clean*  

### 3️⃣ Drawback  

One drawback to Makefiles is that they are exceedingly picky. You must indent the steps in a target with a tab. They are also not supported out-of-the-box on Windows.
If you are doing your Go development on a Windows computer like me, you need to installmake first. The easiest way to do so is to first install a package manager like [Chocolatey](https://chocolatey.org/) and then use it to install make by running below command from Powershell (run as admininstrator).

```powershell
choco install make
```

### 4️⃣ Conclusion  

From the current version of Go, as i observed there has been a new major release roughly every six months. There are also minor releases with bug and security fixes released as needed. 
Given the rapid development cycles and the Go team’s commitment to backward compatibility, Go releases tend to be incremental rather than expansive and The [Go Compatibility Promise](https://go.dev/doc/go1compat) backward compatibility guarantees with minor limitations. which i also belive will not complecate Go for lerners and Developers in future.  