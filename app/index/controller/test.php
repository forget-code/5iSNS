<?php

!defined('DEBUG') AND exit('Access Denied.');

            $data['description'] = '下载';
            $data['uid'] = 1;
            $data['to_uid'] = 2;
            $data['itemid'] = 3;
            point_note_op(1,2,'point','-',$data);