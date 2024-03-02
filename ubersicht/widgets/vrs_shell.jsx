// This is a simple example Widget to get you started with Übersicht.
// For the full documentation please visit:
// https://github.com/felixhageloh/uebersicht

import { run } from 'uebersicht'

// this is the shell command that gets executed every time this widget refreshes
export const command = '~/dots/bin/vrs_shell';

// the refresh frequency in milliseconds
export const refreshFrequency = false;

// the CSS style for this widget, written using Emotion
// https://emotion.sh/
export const className =`
font-family: --apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen,
        Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
font-weight: 400;
font-size: 14px;

box-sizing: border-box;

::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-thumb {
    background: var(--gray4);
    border-radius: 4px;
}

::-webkit-scrollbar-track {
    background: transparent;
}

.container {
    border-radius: 10px;
    width: 300px;
    padding-top: 40px;
    height: 300px;

    position: fixed;
    bottom: 20px;
    left: 20px;

    padding: 10px;
    -webkit-box-shadow: 10px 10px 47px 0px rgba(0,0,0,0.54);
    letter-spacing: 1px;
    background-color: rgba(255,255,255,0.8);
    color: black;
}

.mainBox {
    overflow-y: auto;
    height: 100%;
}

.container::-webkit-scrollbar {
    display: none;
}

.taskBox {
    display: flex;
    flex-direction: column;
    min-height: 140px;
}

.header h2 {
    margin-top: 5px;
    margin-bottom: 5px;
}

.separator {
    background-color: rgba(0,0,0,0.2);
    height: 1px;
    margin-bottom: 5px;
}

.nothing {
    text-align: center;
    height: 50px;
    margin-top: 45px;
}

.task {
    padding: 5px 0;
    display: flex;
    flex-direction: row;
}

.task::before {
    content: "";
    width: 10px;
    height: 10px;
    border-radius: 20px;
    border-style: solid;
    border-color: mediumseagreen;
    background: rgba(0,0,0,0.2);
    background: transparent;
    left: 0px;
    margin-top: 3px;
}

.task--rlist::before {
    border-color: #E09203;
}

.task .title {
    font-size: 16px;
    font-weight: 500;
    margin-left: 8px;
    margin-bottom: 8px;
}
`

// render gets called after the shell command has executed. The command's output
// is passed in as a string.
export const render = ({output}) => {

    const [todos_str, rlist_str] = output.split("<SEP>");
    const todos = todos_str.split('\n').filter((s) => s.length > 0);
    const rlist = rlist_str.split('\n').filter((s) => s.length > 0);

    let idx = 0;

    let todo_elems;
    if (todos.length === 0) {
        todo_elems = (
            <div class='nothing'>No Tasks</div>
        );
    } else {
        todo_elems = todos.map((it) => (
            <div key={idx++} class="task">
                <div class="leftBox">
                </div>
                <div class="rightBox">
                    <div class="title">
                        {it}
                    </div>
                </div>
            </div>
        ));
    }

    let rlist_elems;
    if (rlist.length === 0) {
        rlist_elems = (
            <div class='nothing'>No Links</div>
        );
    } else {
        rlist_elems = rlist.map((it) => (
            <div key={idx++} class="task task--rlist">
                <div class="leftBox">
                </div>
                <div class="rightBox">
                    <div class="title">
                        {it}
                    </div>
                </div>
            </div>
        ));
    }


    return (
        <div class="container">
            <div class="mainBox">
                <div class="taskBox">
                    <div class='header'>
                        <h2>Tasks</h2>
                    </div>
                    <div class="separator"></div>
                    {todo_elems}
                </div>
                <div class="taskBox">
                    <div class='header'>
                        <h2>Reading List</h2>
                    </div>
                    <div class="separator"></div>
                    {rlist_elems}
                </div>
            </div>
        </div>
    );
}

