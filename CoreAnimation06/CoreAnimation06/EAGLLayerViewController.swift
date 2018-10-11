//
//  EAGLLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/11.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit
import GLKit
import OpenGLES

class EAGLLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()

        glContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        EAGLContext.setCurrent(glContext)

        eaglLayer = CAEAGLLayer()
        eaglLayer.frame = containerView.bounds
        containerView.layer.addSublayer(eaglLayer)

        eaglLayer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking: false,
                                        kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8]
        effect = GLKBaseEffect()
        setupBuffers()
        drawFrame()

        // tip: 失败了, 太难用了
        // iOS 12 废弃 OpenGLES, 使用 Metal
    }

    deinit {
        tearDownBuffer()
        EAGLContext.setCurrent(nil)
    }

    func setupBuffers() {
        glGenBuffers(1, &frameBuffer)
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), frameBuffer)

        glGenRenderbuffers(1, &colorRenderBuffer)
        glBindFramebuffer(GLenum(GL_RENDERBUFFER), colorRenderBuffer)

        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), colorRenderBuffer)
        glContext?.renderbufferStorage(Int(GL_RENDERBUFFER), from: eaglLayer)

        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_WIDTH), &frameBufferWidth)
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_HEIGHT), &frameBufferHeight)

        let status = glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER))
        if status != GLenum(GL_FRAMEBUFFER_COMPLETE) {
            print("Failed to make complete framebuffer object: %i", status)
        }
    }

    func tearDownBuffer() {
        glDeleteBuffers(1, &frameBuffer)
        frameBuffer = 0

        glDeleteBuffers(1, &colorRenderBuffer)
        colorRenderBuffer = 0
    }

    func drawFrame() {
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), frameBuffer)
        glViewport(0, 0, frameBufferWidth, frameBufferHeight)
        effect.prepareToDraw()

        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        glClearColor(0, 0, 0, 1)

        let vertices: [GLfloat] = [-0.5, -0.5, -1.0, 0.0, 0.5, -1.0, 0.5, -0.5, -1.0]
        let colors: [GLfloat] = [0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0]

        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue))
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.color.rawValue))
        glVertexAttribPointer(GLuint(GLKVertexAttrib.position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, vertices)
        glVertexAttribPointer(GLuint(GLKVertexAttrib.color.rawValue), 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, colors)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)

        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorRenderBuffer)
        glContext?.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }

    var glContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
    var eaglLayer = CAEAGLLayer()
    var frameBuffer: GLuint = 0
    var colorRenderBuffer: GLuint = 0
    var frameBufferWidth: GLint = 0
    var frameBufferHeight: GLint = 0
    var effect = GLKBaseEffect()
}
