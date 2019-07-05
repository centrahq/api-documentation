<?php
namespace Grav\Plugin\Shortcodes;

use Thunder\Shortcode\Shortcode\ShortcodeInterface;

class ParamShortcode extends Shortcode
{
    public function init()
    {
        $this->shortcode->getHandlers()->add('parameter', function(ShortcodeInterface $sc) {
            $this->shortcode->addAssets('css', 'theme://css/style.css');

            $param_data = $sc->getParameter('data', false);
            $param_datatype = $sc->getParameter('datatype', false);
            $param_isRequired = $sc->getParameter('isRequired', 'false');
            $param_storetype = $sc->getParameter('storetype', false);
            $param_sublevel = $sc->getParameter('sublevel', 0)*60;
            $css_style = 'margin-left: ' . $param_sublevel . 'px;';

            $data_arr = explode(', ', $param_data);
            $storetype_arr = explode(', ', $param_storetype);

            return 
              '<div class="param" style="'.$css_style.'">
                  <div class="param-tags">
                    <div class="data-wrapper">' . ($data_arr ? $this->dataMapping($data_arr) : '') . '</div>' .
                    ($param_datatype ? '<div class="datatype">'.$param_datatype.'</div>' : '') .
                    ($param_isRequired ==='true' ? '<div class="required">required</div>' : '<div class="optional">optional</div>') .
                    ($param_storetype ? '<div class="storetype-wrapper">' . $this->dataMapping($storetype_arr) . '</div>' : '') .
                  '</div>
                <div class="description">'.$sc->getContent().'</div>
              </div>';
        });
    }

    private function dataMapping($data) {
        $str = '';

        foreach ($data as $v) {
            $str .= '<span>'.$v.'</span>';
        }
        
        return $str;
    }
}