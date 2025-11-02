import React from 'react';

export function DownwardIcon(props) {
    return (
        <svg xmlns="http://www.w3.org/2000/svg"
            width={12}
            height={12}
            viewBox="0 0 24 24"
            {...props}>
            <path
                fill="none"
                stroke="currentColor"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="m8 18l4 4l4-4M12 2v20">
            </path>
        </svg>
    );
}

export default DownwardIcon;
