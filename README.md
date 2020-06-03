# protobuf-repeated-type-vs-any

A simple comparison between a protobuf repeated type (array) versus its repeated [google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Any) counterpart. The same type (`Person`) is used for both.

The idea is to determine the size difference in bytes of binary and JSON formats for the same type stored as an array and as `google.protobuf.Any` type. `Any` stores `type_url` along with the encoded message so naturally it would need more bytes.

## Message Definition ([`person.proto`](person.proto))

```
syntax = "proto3";

package test;

import "google/protobuf/any.proto";

message Person {
    string first_name = 1;
    string last_name = 2;
    int32 age = 3;
}

message PersonAny {
    repeated google.protobuf.Any persons = 1;
}

message PersonArray {
    repeated Person persons = 1;
}
```

### Test Data

The [`persons_data`](person.rb) array contains the data to populate `Person` objects:

```
persons_data = [
    { first_name: "abc", last_name: "def", age: 20 },
    { first_name: "def", last_name: "ghi", age: 21 },
    { first_name: "jkl", last_name: "mno", age: 22 },
    { first_name: "pqr", last_name: "stu", age: 23 },
].freeze
```

### Compile (.proto file)
```
$ protoc --ruby_out=. ./person.proto
```

### Run Script
```
$ ./person.rb
```

Output (bytes):
```
Any:
- Binary : 196
- JSON   : 373
Array:
- Binary : 56
- JSON   : 197
```

## Comparison (bytes)

Here's the comparison in tabular form:

| Type  | Binary | JSON |
|:-----:| ------:| ----:|
| Any   |    196 |  373 |
| Array |     56 |  197 |
