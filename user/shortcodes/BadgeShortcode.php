<?php
namespace Grav\Plugin\Shortcodes;

use Thunder\Shortcode\Shortcode\ShortcodeInterface;

class BadgeShortcode extends Shortcode
{
    public function init()
    {
        $this->shortcode->getHandlers()->add('badge', function(ShortcodeInterface $sc) {
            $this->shortcode->addAssets('css', 'theme://css/style.css');
            return '<span class="badge">'.$sc->getContent().'</span>';
        });
    }
}