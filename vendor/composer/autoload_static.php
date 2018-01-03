<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit957e16ec1846e9619e5fc0f5ef39ef23
{
    public static $files = array (
        '1cfd2761b63b0a29ed23657ea394cb2d' => __DIR__ . '/..' . '/topthink/think-captcha/src/helper.php',
    );

    public static $prefixLengthsPsr4 = array (
        't' => 
        array (
            'think\\composer\\' => 15,
            'think\\captcha\\' => 14,
        ),
        'a' => 
        array (
            'app\\' => 4,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'think\\composer\\' => 
        array (
            0 => __DIR__ . '/..' . '/topthink/think-installer/src',
        ),
        'think\\captcha\\' => 
        array (
            0 => __DIR__ . '/..' . '/topthink/think-captcha/src',
        ),
        'app\\' => 
        array (
            0 => __DIR__ . '/../..' . '/application',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit957e16ec1846e9619e5fc0f5ef39ef23::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit957e16ec1846e9619e5fc0f5ef39ef23::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
