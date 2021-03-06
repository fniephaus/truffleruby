# TruffleRuby Additional Functionality

TruffleRuby is intended to be usable as a standard Ruby implementation that runs
programs developed on other implementations, but it also provides additional
functionality beyond that of other implementations.

Also see the [document describing our compatibility](compatibility.md) with
other Ruby implementations.

## Detecting if you are running on TruffleRuby

You can use the `--version` command-line option. TruffleRuby will report for
example:

```
truffleruby ..., like ruby ... <Java HotSpot(TM) 64-Bit Graal VM ... with Graal> [darwin-x86_64]
```

In Ruby code, you can look at the standard `RUBY_ENGINE` constant, which will be
`'truffleruby'`.

It is also possible to use feature-detection instead of looking at
`RUBY_ENGINE`. For example if you are writing an application that uses
TruffleRuby's interoperability with Java you could test for `defined?(Java)`,
which will be set when in hosted mode on the JVM but not in native mode.

TruffleRuby is an integral part of GraalVM, so the version number of TruffleRuby
is always the same as the version of GraalVM that contains it. If you are using
TruffleRuby outside of GraalVM, such as a standard JVM, the version will be
`'0.0'`. You can find the version number of GraalVM and TruffleRuby using the
standard `RUBY_ENGINE_VERSION` constant.

## TruffleRuby methods

TruffleRuby provides these non-standard methods that provide additional
functionality in the `TruffleRuby` module.

`TruffleRuby.graal?` reports if the Graal compiler is available and will be
used.

`TruffleRuby.native?` reports if TruffleRuby has been ahead-of-time compiled.
In practice this implies that the SubstrateVM is being used.

`TruffleRuby.sulong?` reports if TruffleRuby has the Sulong interpreter for C
extensions available.

`TruffleRuby.revision` reports the source control revision used to build
TruffleRuby.

`TruffleRuby.full_memory_barrier` ensures lack of reordering of loads or stores
before the barrier with loads or stores after the barrier.

## Polyglot programming

The `Polyglot` and `Java` modules provides access to the polyglot programming
functionality of GraalVM. They are
[described in a separate document](polyglot.md).

## Unsupported additional functionality

You may be able to find some other modules and methods not listed here that look
interesting, such as `Truffle::POSIX` or `Truffle::FFI`. Additional modules and
methods not listed in this document are designed to support the implementation
of TruffleRuby and should not be used. They may be modified or made not visible
to user programs in the future, and you should not use them.
