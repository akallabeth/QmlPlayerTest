#include <QDebug>
#include <QMediaPlayer>
#include <QFile>

#include "rdpstreamplayer.h"

namespace com {
namespace thincast {

RDPStreamPlayer::RDPStreamPlayer(QObject *parent, Flags flags) :
    QMediaPlayer(parent, flags)
{
    qDebug() << __func__;
}

void RDPStreamPlayer::setVideoSurface(QAbstractVideoSurface *surface) {
    qDebug() << __func__;
    m_surface = surface;
    setVideoOutput(m_surface);
}

QAbstractVideoSurface *RDPStreamPlayer::getVideoSurface() {
    qDebug() << __func__;
    return m_surface;
}

QUrl RDPStreamPlayer::source() const {
    qDebug() << __func__;
    return m_source;
}

void RDPStreamPlayer::setSource(const QUrl &url) {
    qDebug() << __func__;
    if (url == m_source) {
        return;
    }

    m_source = url;
#if 1
    QFile *file = new QFile(m_source.toLocalFile());
    file->open(QFile::ReadOnly);
    QMediaPlayer::setMedia(0, file);
#else
    QMediaPlayer::setMedia(m_source);
#endif
    emit sourceChanged();
}
}
}
