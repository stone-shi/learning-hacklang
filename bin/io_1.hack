#!/usr/bin/env hhvm


use namespace HH\Lib\{File, IO};

<<__EntryPoint>>
async function main_async(): Awaitable<void> {
    require_once(__DIR__.'/../vendor/autoload.hack');
    \Facebook\AutoloadMap\initialize();

    $out = IO\request_output();
    $message = "Hello world!\n";
    await $out->writeAllAsync($message);

    using ($tf = File\temporary_file()) {
        $f = $tf->getHandle();
        await $f->writeAllAsync($message);
        $f->seek(0);
        $content = await $f->readAsync();
        await $out->writeAllAsync($content);
    }
}
