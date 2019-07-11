<?php
namespace Grav\Plugin\Shortcodes;

use Thunder\Shortcode\Shortcode\ShortcodeInterface;

class NoticeBoxShortcode extends Shortcode
{
    public function init()
    {
        $this->shortcode->getHandlers()->add('notice-box', function(ShortcodeInterface $sc) {
            $this->shortcode->addAssets('css', 'theme://css/style.css');
            $type = $sc->getParameter('notice-box', $this->getBbCode($sc)) ?: 'info';
            return '<div class="notice-box '.$type.'"><div>'.$sc->getContent().'</div></div>';
        });
    }
}