import { motion } from "framer-motion"

const container = (delay) => ({
    hidden: { x: -100, opacity: 0 },
    visible: {
        x: 0,
        opacity: 1,
        transition: { duration: 0.5, delay: delay }
    }
})

const Hero = () => {
    return (
        <div className="border-b border-neutral-300 pb-4 lg:mb-35 flex justify-center items-start min-h-screen pt-16 lg:pt-24 bg-white">
            <div className="flex flex-col items-center">
                <motion.h1
                    variants={container(0)}
                    initial="hidden"
                    animate="visible"
                    className="pb-10 text-6xl font-thin tracking-tight text-center lg:text-8xl text-gray-900"
                >
                    Lorenzo Cardoso
                </motion.h1>
                <motion.span
                    variants={container(0.5)}
                    initial="hidden"
                    animate="visible"
                    className="text-3xl tracking-tight text-gray-600 text-center"
                >
                    Desenvolvedor Mobile
                </motion.span>
            </div>
        </div>
    );
};

export default Hero