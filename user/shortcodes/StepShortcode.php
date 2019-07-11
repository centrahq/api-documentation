<?php
namespace Grav\Plugin\Shortcodes;

use Thunder\Shortcode\Shortcode\ShortcodeInterface;

class StepShortcode extends Shortcode
{
    public function init()
    {
        $this->shortcode->getHandlers()->add('step', function(ShortcodeInterface $sc) {
            $this->shortcode->addAssets('css', 'theme://css/style.css');
            $step = $sc->getParameter('step', $this->getBbCode($sc));
            return '<span class="step">'.$step.'</span>';
        });
    }
}