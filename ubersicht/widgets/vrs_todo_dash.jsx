// This is a simple example Widget to get you started with Übersicht.
// For the full documentation please visit:
// https://github.com/felixhageloh/uebersicht

import { run } from 'uebersicht'

// this is the shell command that gets executed every time this widget refreshes
export const command = '~/dots/bin/vrs_todo_dash';

// the refresh frequency in milliseconds
export const refreshFrequency = 60000;

// the CSS style for this widget, written using Emotion
// https://emotion.sh/
export const className =`
  bottom: 20px;
  left: 20px;
  box-sizing: border-box;
  margin: auto;
  padding: 8px 18px;
  background-color: rgba(255, 255, 255, 0.5);
  background-image: url('logo.png');
  background-repeat: no-repeat;
  background-size: 176px 84px;
  background-position: 50% 20px;
  -webkit-backdrop-filter: blur(20px);
  color: rgba(0, 0, 0, 0.8);
  font-family: Helvetica Neue;
  font-weight: 300;
  border-radius: 8px;
  text-align: justify;

  h1 {
    font-size: 18px;
    word-break: break-word;
  }

  h2 {
    font-size: 12px;
    word-break: break-word;
  }
`

// render gets called after the shell command has executed. The command's output
// is passed in as a string.
export const render = ({output}) => {
    const todos = output.split('\n').filter((s) => s.length > 0);
    const todo_elems = todos.map((it) => (<h2>{it}</h2>));

    return todos.length ? (
        <div>
            <h1>Tasks: {todos.length}</h1>
            {todo_elems}
        </div>
    ) : (
        <div>
            <h1>No Tasks</h1>
        </div>
    );
}

