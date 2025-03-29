<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '&#^x;nl||x9I96rX;O596m(aWux N72Ywn>Yx)kZF-|TAEh/w(1H=li?C!3P;Zb>' );
define( 'SECURE_AUTH_KEY',   'a_:MO,^[d$2[^>-5miKZ(p9^?PP_PFdEZ{3tI%6i_]ap@;/bIDF(N_hE7!,o,Y[X' );
define( 'LOGGED_IN_KEY',     '%i_?=po<@_7}f/hPXuUX6bv<gP|Qpo3S}aWg)_Z^~W>jywdpOlT~A f1t~E`<3lg' );
define( 'NONCE_KEY',         'KL QXk>euHm]Wq.NL#X,hi+C64M0@lIXG&eskB9u D%nPcHlhLm!C/I_+#z>HhFL' );
define( 'AUTH_SALT',         'LS lq@m=uLjt9a@)q,ZcGJ*eQ9v@/NwS!Oma<oR?%m=rHiK.A3cQIh}bQm3b}d]?' );
define( 'SECURE_AUTH_SALT',  'X.1v7nO5qqZ!t- _MtBsi/[=8<iNAgMp5E8e49Sd|1!$m`4,Lmg,V@$(s5fKEb+^' );
define( 'LOGGED_IN_SALT',    'ZDJ{In`dR{Cr*$z`B;$mm>C0-8zluZWC}HD<yQj)8MDM;l3L{2^p-$%HK.7:CBol' );
define( 'NONCE_SALT',        'h/1.;F,r;q4=&|p,aM+O]-Bk7^{(.M;l7.dh@@*&Ue P&322>|w,mo^+S>ouk Hs' );
define( 'WP_CACHE_KEY_SALT', 'ibk[qC@,4,t9zPQu^pHs_|jOF;6+hs0hU)b}(FEgG{-d%//JT<n_H9[40!CsLsOv' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
